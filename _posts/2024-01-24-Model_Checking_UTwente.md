---
title: Model Checking UTwente
author: Zhibeau
date: 2024-01-24 11:06:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_01_24/
categories: [Notes]
tags: [Cybersecurity, Security Analysis]
---

Switch between a modeling formalism and the logic you can use for model checking.

## Transition system

- **Nodes**: States         (e.g., Current color of the traffic light.)
- **Edges**: Transitions    (e.g., Swtich from one color to another.)

### Labeled transition systems

A labeled transition system (LTS) is a triple (*S,T,L*) with:

- *S*: states
- *T*: Transition relation (s<sub>1</sub>,s<sub>2</sub>) := possible transition from s<sub>1</sub> to s<sub>2</sub>
- *L*: Labeling function: *L*:*S*->*AP*, where *AP* is a finite set of atomic propoerties 
- Path: a sequence of states (s<sub>1</sub>,s<sub>2</sub>,...), such that for all i $>$=0, (s<sub>i</sub>,s<sub>i+1</sub>)$\in$ *T* 

### State and path properties

- State properties $\Phi$ : "Which" properties are true in "Which" properties

- Path properties $\phi$: Something about the validity of some paths originating from a particular state

## Computational Tree Logic

State properties $\Phi$ :¬, ∨, $\exists$, $\forall$  

State properties $\phi$ :**$\times$**,$\square$,$\cup$ $\Diamond$

![](2024-01-23-12-21-41-image.png)

#### Property specification

<img src="file:///C:/Users/zzhib/AppData/Roaming/marktext/images/2024-01-23-12-24-20-image.png" title="" alt="" width="366">

<img title="" src="file:///C:/Users/zzhib/AppData/Roaming/marktext/images/2024-01-23-12-27-44-image.png" alt="" width="365">

![](2024-01-23-12-50-22-image.png)

![](2024-01-23-12-51-01-image.png)

## CTL Model Checking formulation

![](2024-01-23-13-22-16-image.png)

## Existential normal form of CTL

For each CTL formula, there is an equivalent formula in $\exists$-normal form

![](2024-01-23-14-19-56-image.png)

### Excersices

![](2024-01-24-13-39-24-image.png)

answer: state 3

![](2024-01-24-13-40-50-image.png)

answer: state 1,2,3,4

## Markov Chain

- Add **probabilities** of taking transitions between states

- Add **time** by specifying how long will a system stay in a state

- **Memorylessness**: Future evolution is independent of its past states

- **Memorylessness**: The current state of the model contains all information that can influence the future evolution.
  
  ![](2024-01-23-19-29-25-image.png)

### Discret Time Markov Chain Definition

**Utilization of the DTMC**: Which states will be reached at what probability after *k* steps?

![](2024-01-23-19-12-51-image.png)

- for the stochastic matrix P:

- P has Eigenvalue 1 and all Eigenvalues are at most 1

- P<sup>n</sup> is a stochastic matrix, for all n

### Example of the transition of a markov chain

<img src="file:///C:/Users/zzhib/AppData/Roaming/marktext/images/2024-01-23-19-51-03-image.png" title="" alt="" width="489">
