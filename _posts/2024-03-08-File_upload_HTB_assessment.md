---
title: File upload HTB skill assessment
author: Zhibeau
date: 2024-03-08 23:26:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_03_08/
categories: [Notes, HTB]
tags: [File upload, Pentest]
---

## Introduction

This is the skill assessment section in the File Upload Attack module of the HTB. We are going to use the skills learned - including the front-end filter, black list filter, whitelist filter and   -  to get the flag at the root directory.

## Path to the flag

**1. Front-end verification**: 

Firstly, we find the file upload page of the target site. When inspecting the page, we found that there is a front-end file verification function. Only after deleting it can we send a file upload request containing the payload.

![1_Frontend_Verification.png](1_Frontend_Verification.png)

**2. Read source code with XXE**: 

To avoid fuzzing, we can try read the source code of the upload filter. We can try XXE with a svg file. The reponse will contain the source code encoded in base64.

![2_svg_xxe_read_source_code.png](2_svg_xxe_read_source_code.png)

```php
<?php
require_once('./common-functions.php');

// uploaded files directory
$target_dir = "./user_feedback_submissions/";

// rename before storing
$fileName = date('ymd') . '_' . basename($_FILES["uploadFile"]["name"]);
$target_file = $target_dir . $fileName;

// get content headers
$contentType = $_FILES['uploadFile']['type'];
$MIMEtype = mime_content_type($_FILES['uploadFile']['tmp_name']);

// blacklist test
if (preg_match('/.+\.ph(p|ps|tml)/', $fileName)) {
    echo "Extension not allowed";
    die();
}

// whitelist test
if (!preg_match('/^.+\.[a-z]{2,3}g$/', $fileName)) {
    echo "Only images are allowed";
    die();
}

// type test
foreach (array($contentType, $MIMEtype) as $type) {
    if (!preg_match('/image\/[a-z]{2,3}g/', $type)) {
        echo "Only images are allowed";
        die();
    }
}

// size test
if ($_FILES["uploadFile"]["size"] > 500000) {
    echo "File too large";
    die();
}

if (move_uploaded_file($_FILES["uploadFile"]["tmp_name"], $target_file)) {
    displayHTMLImage($target_file);
} else {
    echo "File failed to upload";
}
```

**3. Analyze the filter**: 

1. **Blacklist :** The code uses a regular expression to block file uploads that have an extension matching `.php`, `.phps`, or `.phtml`. This is aimed at preventing the upload of executable PHP scripts.

2. **Whitelist :** It checks that the file name ends with a pattern that seems to intend to allow only images. The regex pattern looks for file names ending with a period followed by 2 to 3 characters and then a "g" (e.g., `.jpg`, `.png`), aiming to match common image extensions.

3. **Type :** This part checks both the `Content-Type` header and the MIME type of the actual file content, looking for types that start with `image/` and end with 2 to 3 characters followed by "g" (matching types like `image/jpeg` or `image/png`).

4. **Size :** The file must be smaller than 500,000 bytes.

**4. Bypass the MIME type filter**: 

The filter about the file name,`Content-Type`, or size is easy to bypass. But we need to craft a pretending legitimate picture to bypass the MIME type filter. [The wikipedia]([List of file signatures - Wikipedia](https://en.wikipedia.org/wiki/List_of_file_signatures)contains the signature of different types of file. We notice that `FF D8 FF D8` is the signature of the `.jpg` file. Let's add this at the beginning of our payload.

![3_jpg_magic_byte.png](3_jpg_magic_byte.png)

**5. Remote code execution**:

From the source code we can also find that the directory storing the uploaded file: `./user_feedback_submissions/` and the name of the file will get a data prefix: ```fileName = date('ymd') . '_' . basename(_FILES["uploadFile"]["name"]);``` Knowing this, we can visit the payload and execute our code. The flag is then obtained.

![4_RCE.png](4_RCE.png)