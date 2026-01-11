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
        left: 80px;
        right: 70px;
        font-size: 0.75em;
        color: #666;
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

*[Lingchi](https://en.wikipedia.org/wiki/Lingchi), or "death by a thousand cuts"*

</center>

---

## Agenda

How to:
1. Control your benchmarking environment
2. Design your benchmarks
3. Interpret benchmark results
4. Integrate benchmarks into your workflows

---

# How to control your benchmarking environment

---

<center>

![width:600](./assets/cern-to-gran-sasso-neutrino-beam.jpg)

*732 km neutrino beam path from CERN in Geneva to Gran Sasso \[1\]*

</center>

---

<center>

![width:600](./assets/opera-loose-cable-upscaled.png)

*Loose fiber optic cable that caused the measurement error \[2\]*

</center>

---

<div class="section-header">How to control your benchmarking environment</div>

## Sources of Noise

- Memory layout \[3\]
- Compilation and linking \[3\]
- Available resources on colocated logical cores \[4\]
- Network instability \[5\]
- Scheduler latency \[5\]
- Vibration \[5\]
- CPU power saving mechanisms \[6\]
- CPU overheating prevention mechanisms \[6\]
- Build quality of cores \[7\]

---

<div class="section-header">How to control your benchmarking environment</div>

## System Tweaks

Here are the main tweaks you can do. We're going to investigate one at a time to see their effects.

- **Hyper-threading (SMT)**
- **Turbo Boost**
- **C-states**

<span class="comment">

Please note that results come from experiments, not production configurations.

Experiments designed and run by Dmytro Yurchenko.

</span>

---

<div class="section-header">How to control your benchmarking environment</div>

## Hyper-threading (SMT)

Two logical cores share one physical core's execution resources (ALUs, caches). When both are active, they compete for resources.

```bash
# Disable SMT
echo off > /sys/devices/system/cpu/smt/control
```

<span class="comment">

**TODO:** Add before/after CoV visualization from m5metal_hyperthreading experiment.

Key result: BLAS benchmark — same core 1.95x slower, 56x higher variance.

</span>

---

<div class="section-header">How to control your benchmarking environment</div>

## Turbo Boost

Dynamic frequency scaling that temporarily boosts CPU frequency above base clock. Frequency varies based on thermal headroom and number of active cores.

```bash
# Disable Turbo Boost
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
```

<span class="comment">

**TODO:** Add before/after CoV visualization from m5metal_turboboost experiment.

Key result: With turbo on, performance varies with task count (533ms → 578ms). With turbo off, consistent regardless of task count.

</span>

---

<div class="section-header">How to control your benchmarking environment</div>

## C-states

CPU power-saving sleep states. Deeper C-states save more power but have higher wake-up latency, introducing variance in latency-sensitive workloads.

```bash
# In GRUB_CMDLINE_LINUX_DEFAULT:
intel_idle.max_cstate=1 processor.max_cstate=1
```

<span class="comment">

**TODO:** Add visualization from m5metal_cstate experiment.

Key finding: C0 forcing creates outliers; C1 vs C6 shows similar repeatability for most workloads.

</span>

---

<div class="section-header">How to control your benchmarking environment</div>

## Other Tweaks

There are many other CPU tweaks you can explore:

- Scaling governor (set to `performance`)
- CPU affinity (pin processes to specific cores)
- Process priority (reduce OS interruptions)
- Filesystem cache (warm up or drop before measuring)

**References:**

- Gregg, B. *Systems Performance*, 2nd ed., Ch. 6 \[6\]
- Bakhvalov, D. *Performance Analysis and Tuning on Modern CPUs*, App. A \[8\]

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

---

# References

\[1\] "Neutrino oscillations in the neutrino beam from CERN to Gran Sasso." https://www.uni-muenster.de/Physik.KP/en/AGFrekers/forschung/opera.html

\[2\] Strassler, M. (2012). "OPERA: What Went Wrong." https://profmattstrassler.com/articles-and-posts/particle-physics-basics/neutrinos/neutrinos-faster-than-light/opera-what-went-wrong/

\[3\] Kalibera, T., Bulej, L., and Tuma, P. (2005). "Benchmark Precision and Random Initial State."

\[4\] Valles, A. (2009). "Performance Insights to Intel Hyper-Threading Technology." https://web.archive.org/web/20150217050949/https://software.intel.com/en-us/articles/performance-insights-to-intel-hyper-threading-technology/.

---

\[5\] Gregg, B. (2014). "Frequency Trails: Outliers." https://www.brendangregg.com/FrequencyTrails/outliers.html#Causes

\[6\] Gregg, B. (2020). "Systems Performance: Enterprise and the Cloud.", p. 233, "P-states and C-states."

\[7\] Humenay, E., Tarjan, D., and Skadron, K. (2007). "Impact of Process Variations on Multicore Performance Symmetry."

---

\[8\] Bakhvalov, D. (2024). *Performance Analysis and Tuning on Modern CPUs*. https://www.amazon.com/Performance-Analysis-Tuning-Modern-CPUs/dp/B0DMVQ1QDD