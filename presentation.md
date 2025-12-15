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
    .section-header {
        position: absolute;
        top: 40px;
        left: 70px;
        right: 70px;
        font-size: 0.8em;
        color: #666;
        letter-spacing: 0.1em;
        border-bottom: 1px solid #ddd;
        padding-bottom: 5px;
    }
---

Slides roughly reflect the structure we're aiming to follow, but `outline.md` is a more complete document outlining the presentation.

---

# How to Reliably Measure Software Performance

Augusto de Oliveira, Kemal Akkoyun

FOSDEM 2026

---

<center>

![width:500](./assets/death-by-a-thousand-cuts.jpg)

*Lingchi - "death by a thousand cuts"*

</center>

---

## Agenda

1. How to control your benchmarking environment
2. How to design your benchmarks
3. How to interpret benchmark results
4. How to integrate benchmarks into your workflows

---

<center>

![width:600](./assets/opera-detector.jpeg)

*The OPERA neutrino detector*

</center>

---

<center>

![width:600](./assets/opera-loose-cable.png)

*The loose fiber optic cable that caused the measurement error*

</center>

---

# Controlling the Environment

---

<div class="section-header">Controlling the Environment</div>

## Sources of Noise

- Memory layout
- Non-determinism in compilation and linking
- Non-determinism in available resources on colocated logical cores
- Network instability
- Scheduler latency
- Vibration
- Variable clock rate
- Build quality of cores
- CPU power saving mechanisms
- CPU overheating prevention mechanisms

---

<div class="section-header">Controlling the Environment</div>

## System Tweaks

<span class="comment">

**Purpose:** Show practical system tweaks for benchmarking and how to implement them.

Content to add:
- Pin CPU frequency to 2.5 GHz (prevents frequency scaling)
- Prevent Intel CPUs from sleeping when idle (max_cstate=1)
- Set CPU scaling governor to "performance" mode
- Dedicate 4 CPUs exclusively for system workloads
- Disable Intel P-state driver (revert to ACPI frequency scaling)
- Disable hyperthreading/SMT on physical cores
- Disable Intel Turbo Boost feature

Include code snippets from the GitLab runner config.

</span>

---

<div class="section-header">Controlling the Environment</div>

## Before and After

<center>

![width:300](./assets/placeholder.jpg)

*Effect of controlling environmental noise on benchmark stability*

</center>

<span class="comment">

**Purpose:** Show visual comparison of benchmark results before and after controlling environmental noise.

</span>

---

# Benchmark Design

---

<div class="section-header">Benchmark Design</div>

<center>

<span class="comment">

**TODO:** Segway to the benchmark design section with an analogy or story.

</span>

</center>

---

## Some Terminology

<span class="section-header">Benchmark Design</span>

<center>

![width:300](./assets/placeholder.jpg)

*Diagram: Benchmarking harness (load generator) → System under test*

</center>

---

## Some Terminology

**System under test:** What is being measured
**Harness:** What measures it
- **Operations:** Single execution
- **Iterations:** Batch of operations measured together
- **Repetitions:** Number of times you run the harness

<span class="comment">

**TODO:** Concrete examples for each of the above.

</span>

---

## What Makes Up a Benchmark?

<span class="section-header">Benchmark Design</span>

<center>

![width:300](./assets/placeholder.jpg)

*micro benchmarks (single functions) vs macro benchmarks (full systems)*

</center>

<span class="comment">

**Purpose:** Simple visual explanation of what benchmarks are, plus a difference between micro and macro benchmarks.

</span>

---

## What Makes a Good Benchmark?

- Repeatability 
- Representativeness
- Consistency
- Robustness

<span class="comment">

**TODO:** Concrete examples for each of the above.

</span>

---

## How to Get Your Benchmarks to a Good State

- Use realistic scenarios and data that match production usage
- Run sufficient sample sizes: **30+ iterations, 10+ repetitions**
- Include warm-up time for JIT-compiled languages
- Use dedicated, isolated hardware (avoid shared/cloud runners)
- Measure variability: aim for **Coefficient of Variation < 2%**
- Use load generators that avoid the coordinated omission problem

**TODO:** Maybe split into different slides with more in-depth explanations and concrete examples for each.

---

# Interpreting Benchmark Results

---

## The Naive Approach Isn't Enough

<center>

![width:300](./assets/placeholder.jpg)

*Two noisy signals with different means but insufficient statistical difference*

</center>

<span class="comment">

- **TODO:** Maybe remove the title for this slide to make the image more impactful.

</span>

---

<div class="columns">

<div>

<center>

![width:300](./assets/placeholder.jpg)

*Highly overlapping histograms*

</center>

</div>

<div>

<center>


![width:300](./assets/placeholder.jpg)

*Clearly different histograms*

</center>

</div>

</div>

<span class="comment">

**Purpose:** Show the intuition behind hypothesis testing.

</span>

---

# Integrating Benchmarks Into Your Workflows

---

<center>

![width:300](./assets/placeholder.jpg)

*Architecture diagram with highlighted integration points: CI/CD, quality gates, operational excellence reviews, competitor benchmarks*

</center>

<span class="comment">

**Purpose:** Show the overall benchmarking platform architecture and how it integrates with development workflows.

</span>

---

## Real-Life Example

<span class="comment">

**Purpose:** Showcase a real-life example to thread through the integration workflows.

**TODO:** decide on specific example, include real numbers and graphs, show concrete benefits.

We're going to have a slide for each highlighted box in the benchmarking platform architecture diagram, referring to the example and including real numbers and graphs to bring the point home.

</span>

---

# Concluding slides

<span class="comment">

**TODO:** Conclusion (summarizing the takeaways), thank you/questions, contact information, references.

</span>
