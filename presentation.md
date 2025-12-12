--- 
marp: true
theme: default
math: mathjax

# columns usage: https://github.com/orgs/marp-team/discussions/192#discussioncomment-1516155
style: |
    .columns {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 1rem;
    }
    .comment {
        color: #888;
    }
---

# How to Reliably Measure Software Performance

Augusto de Oliveira, Kemal Akkoyun

FOSDEM 2026

---

<center>

![width:400](./assets/death-by-a-thousand-cuts.jpg)

*[Lingchi, usually translated as "death by a thousand cuts"](https://en.wikipedia.org/wiki/Lingchi)*

</center>

<center>

<span class="comment">_TODO: Refine analogy to create a strong start. Here we want to describe how performance degradation accumulates gradually as code is added to a project. As a conclusion, we must be able to have systems in place to detect even very small changes in performance._</span>

</center>

---

<div class="columns">

<div>

<center>

![width:500](./assets/ideal-performance-regression.png)

*What we usually expect when thinking of performance changes*

</center>

</div>

<div>

<center>

![width:500](./assets/actual-performance-regression.png)

*What we usually have*

</center>

</div>

</div>

<center>

<span class="comment">_TODO: This slide drives the "death by a thousand cuts" point home. Update the images with more recent examples, and include two examples of performance degradation (currently, the first one is actually a performance improvement)_</span>

</center>

---

<center>

![width:800](./assets/factors-that-impact-performance.png)

</center>

<center>

<span class="comment">TODO: Clean up diagram, make point evident. This slide presents the problem at hand, which is that measuring performance reliably is hard. There are many factors that impact performance, and it is difficult to control them all.</span>

</center>

--- 

1. **Making performance tests reliable**
   1. Controlling environmental noise
   2. Using load testers effectively
   3. Interpreting results correctly

2. **Integrating performance tests into your workflow**
   - Practical strategies for development teams

---

# Part 1
## Making Performance Tests Reliable

---

## Controlling Environmental Noise: Performance Tweaks

<span class="comment">

TODO: Here we show the performance tweaks we do for benchmarking and why. They include: pinning CPU frequencies, preventing CPUs from sleeping when idle, setting processor scaling governors to "performance", dedicating cores to system-specific processes, disabling hyperthreading, disabling turbo-boost, enforcing specific CPU models.

Split into multiple slides, and add code snippets.

</span>

---

## Controlling Environmental Noise: Benchmarking Best Practices

<span class="comment">

TODO: General concepts around benchmarking:

- Differences around micro and macrobenchmark
- How to write good benchmarks (What number of runs? What number of iterations? What should you benchmark?), 
- How to check if they're good (Coefficient of variation? False positive rate?)

Look at our own documentation and enrich this section.

</span>

---

## Using Load Testers Effectively: Coordinated Omission

<span class="comment">

TODO: What the coordinated omission problem is and how to avoid it.

</span>

---

## Using Load Testers Effectively: What Load Testers to Use

<span class="comment">

TODO: What load testers to use for different use cases (vegeta, k6, wrk2, etc.)

</span>

---

## Using Load Testers Effectively: Building Representative Workloads

<span class="comment">

TODO: How to use load test plans and how to build representative workloads (What payloads to send? At what rate?)

</span>

---

## Interpreting Results: General Concepts

<span class="comment">

TODO: Some general concepts about statistics we need:
- What is a normal distribution?
- What is a confidence interval?
- What is a sample size?
- What is a false positive rate? Why are false positive rates _always_ present in any kind of statistical test? What can you do about it?

Maybe:
- What is a normality test?
- What is a p-value?
- What is a t-test?

</span>

---

## Interpreting Results: Using Confidence Intervals

<span class="comment">

TODO: Here we drive the discussion forward about confidence intervals, since they are the most relevant concept the audience needs to understand.

</span>

---

# Part 2
## Integrating Tests Into Your Workflow

---

<span class="comment">

TODO: Share our experience integrating performance tests into our development workflow:
- CI/CD
- Quality gates
- Operational excellence reviews

Maybe include discussions around cultural shifts required to make performance testing a natural part of the development process.

</span>

---

# Thank you!

<span class="comment">

TODO: Refine. Thank you, questions, references, contact information.

</span>

--- 
