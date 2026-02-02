---
marp: true
theme: default
math: mathjax
html: true

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
    .medium {
        font-size: 3em;
    }
    .big {
        font-size: 5em;
    }
    table {
        font-size: 0.7em;
    }
    .centered-table {
        display: flex;
        justify-content: center;
    }
    thead th {
        background-color: #e0e0e0;
    }
    tbody tr {
        background-color: transparent !important;
    }
    .hl {
        background-color: #ffde59;
        padding: 0.1em 0;
    }
    .hl-blue {
        background-color: #1f77b4;
        color: white;
        padding: 0.1em 0.2em;
    }
    .hl-orange {
        background-color: #ff7f0e;
        color: white;
        padding: 0.1em 0.2em;
    }
    .replace {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        line-height: 1.2;
    }
    .replace .old {
        text-decoration: line-through;
        color: #888;
    }
    .replace .new {
        font-weight: bold;
    }
    .bottom-citation {
        position: absolute;
        bottom: 40px;
        left: 80px;
        right: 70px;
        text-align: center;
    }
    .vcenter {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }
    section {
        align-content: start;
        padding-top: 50px;
    }
    section.vcenter {
        align-content: center;
    }
    section.hcenter {
        text-align: center;
    }
    section::after {
        top: 30px;
        bottom: auto;
        left: auto;
        right: 70px;
        font-size: 0.8em;
        color: #666;
    }
    header {
        top: 20px;
        bottom: auto;
        left: 30px;
        right: auto;
        font-size: 0.6em;
        color: #666;
    }
    footer {
        top: auto;
        bottom: 20px;
        left: 30px;
        right: auto;
        font-size: 0.6em;
        color: #666;
    }
    .center {
        text-align: center;
        margin-top: 175px;
    }
    a {
        color: #0066cc;
        text-decoration: underline;
    }
    .fraction {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        vertical-align: middle;
    }
    .fraction .num {
        border-bottom: 2px solid currentColor;
        padding: 0 0.3em 0.2em;
    }
    .fraction .den {
        padding: 0.2em 0.3em 0;
    }
    .hidden {
        visibility: hidden;
    }
---

<!-- _class: vcenter invert -->

# How to Reliably Measure Software Performance

Augusto de Oliveira, Kemal Akkoyun

FOSDEM 2026

---

<!-- paginate: true -->
<!-- _class: vcenter hcenter invert -->

<span class="big">**Performance matters.**</span>

<br>

---

<!-- _class: vcenter hcenter -->

<span class="big">**Performance matters.**</span>

Low latency.

---

<!-- _class: vcenter hcenter -->

<span class="big">**Performance matters.**</span>

Low latency. High throughput.

---

<!-- _class: vcenter hcenter -->

<span class="big">**Performance matters.**</span>

Low latency. High throughput. **Better user experience.**

---

## Performance has real business impact

- **Google**: 500ms delay → 20% traffic drop
- **Yahoo**: 400ms faster → 5-9% more traffic
- **Cloud costs**: $675B+ market by 2024 (Gartner)

<span class="bottom-citation">[1]</span>

---

<!-- _class: vcenter hcenter -->

> "Not all fast software is world-class,
> but all world-class software is fast."

— Tobi Lutke, CEO of Shopify

---

## Users feel the difference

<br>
<br>

<div class="centered-table">

| Response Time | User Perception           |
| ------------- | ------------------------- |
| 100-200ms     | Minimally noticeable      |
| 300-500ms     | Quick but slightly slow   |
| 1-3s          | Amount of work noticeable |
| 5-10s+        | User switches away        |

</div>

---

<!-- _class: vcenter hcenter -->

<div class="medium">

Write benchmarks.
Run them continuously.

</div>

---

<!-- _class: vcenter hcenter invert -->

## Quick poll

---

<!-- _class: vcenter hcenter -->

**Who here has written a benchmark?** 🙋

---

<!-- _class: vcenter hcenter -->

**Who here has written a benchmark?** 🙋

**Who has been surprised by the results?** 🤔

---

<!-- _class: vcenter hcenter invert -->

# But first... why is software slow?

---

## Optimizers can't save us

<!-- prettier-ignore -->
* **CPUs** don't recognize bad algorithms
    - Won't swap bubble sort for quicksort

* **Compilers** rely on heuristics
    - Can't restructure your data layout

* **Big O** hides real-world costs
    - Cache misses, branch mispredictions invisible

<span class="bottom-citation">[1]</span>

---

<!-- _class: vcenter hcenter -->

Matrix multiplication optimization study:

<span class="medium">**60,000x speedup**</span>

through systematic tuning

<br>

_This is why we need to measure._

<span class="bottom-citation">[2]</span>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

# How to Design Benchmarks

---

<!-- _class: vcenter -->

<center>

<span class="medium">**`representative`** and **`repeatable`**</span>

</center>

---

<!-- _class: vcenter hcenter invert -->

## The Art of Writing Benchmarks

---

## Macro vs. Micro Benchmarks

<div class="columns">
<div class="hidden">

### Microbenchmarks

- Test isolated functions/operations
- Nanosecond-level precision
- Prone to compiler tricks
- Risk: **not representative**

</div>
<div class="hidden">

### Macrobenchmarks

- Test end-to-end workflows
- Realistic workloads
- Higher variance
- Risk: **hard to isolate cause**

</div>
</div>

---

## Macro vs. Micro Benchmarks

<div class="columns">
<div>

### Microbenchmarks

- Test isolated functions/operations
- Nanosecond-level precision
- Prone to compiler tricks
- Risk: **not representative**

</div>
<div class="hidden">

### Macrobenchmarks

- Test end-to-end workflows
- Realistic workloads
- Higher variance
- Risk: **hard to isolate cause**

</div>
</div>

---

## Macro vs. Micro Benchmarks

<div class="columns">
<div>

### Microbenchmarks

- Test isolated functions/operations
- Nanosecond-level precision
- Prone to compiler tricks
- Risk: **not representative**

</div>
<div>

### Macrobenchmarks

- Test end-to-end workflows
- Realistic workloads
- Higher variance
- Risk: **hard to isolate cause**

</div>
</div>

---

## Choose the right tool

<br>

<div class="centered-table">

| Use Case                 | Benchmark Type |
| ------------------------ | -------------- |
| Comparing algorithms     | Micro          |
| Validating optimizations | Micro          |
| Regression detection     | Both           |
| Capacity planning        | Macro          |
| User experience          | Macro          |

</div>

---

## Choose the right tool

<br>

<div class="centered-table">

| Use Case                 | Benchmark Type |
| ------------------------ | -------------- |
| Comparing algorithms     | Micro          |
| Validating optimizations | Micro          |
| Regression detection     | Both           |
| Capacity planning        | Macro          |
| User experience          | Macro          |

</div>

_Best practice: Use both in your pipeline._

---

## Representative workloads

What does your application actually do?

---

## Representative workloads

What does your application actually do?

- **CPU-bound**: Number crunching, compression, encryption

<br>

---

## Representative workloads

What does your application actually do?

- **CPU-bound**: Number crunching, compression, encryption
- **I/O-bound**: Database queries, API calls, file operations

<br>

---

## Representative workloads

What does your application actually do?

- **CPU-bound**: Number crunching, compression, encryption
- **I/O-bound**: Database queries, API calls, file operations
- **Mixed**: Most real-world applications

<br>

---

## Representative workloads

What does your application actually do?

- **CPU-bound**: Number crunching, compression, encryption
- **I/O-bound**: Database queries, API calls, file operations
- **Mixed**: Most real-world applications

<br>

_Your benchmark workload should match your production workload._

---

## Workload archetypes

<div class="centered-table">

| Archetype      | Pattern                          | Characteristics                      |
| -------------- | -------------------------------- | ------------------------------------ |
| **Idle**       | Background workers, minimal load | Low RPS, minimal CPU, few workers    |
| **Latency**    | Microservices, APIs              | High RPS, low CPU per request        |
| **Throughput** | Queue workers, batch processing  | Moderate RPS, high CPU, many clients |
| **Enterprise** | Business apps with DB/API calls  | Moderate RPS, mixed CPU / I/O        |

</div>

<br>

<div class="hidden">

_Choose the archetype that matches your application's behavior._

</div>

---

## Workload archetypes

<div class="centered-table">

| Archetype      | Pattern                          | Characteristics                      |
| -------------- | -------------------------------- | ------------------------------------ |
| **Idle**       | Background workers, minimal load | Low RPS, minimal CPU, few workers    |
| **Latency**    | Microservices, APIs              | High RPS, low CPU per request        |
| **Throughput** | Queue workers, batch processing  | Moderate RPS, high CPU, many clients |
| **Enterprise** | Business apps with DB/API calls  | Moderate RPS, mixed CPU / I/O        |

</div>

<br>

<div>

_Choose the archetype that matches your application's behavior._

</div>

---

<!-- _class: vcenter invert -->

# How to Design Benchmarks: Case Study

---

<!-- _class: vcenter -->

<center>

![width:700](./assets/first-time.jpg)

</center>

---

## An non-repeatable benchmark

- Goal: Measuring dd-trace-java instrumentation overhead on a Spring app.

---

## An non-repeatable benchmark

- Goal: Measuring dd-trace-java instrumentation overhead on a Spring app.
- **System under test: Spring app instrumented (or not) with dd-trace-java.**

---

## An non-repeatable benchmark

- Goal: Measuring dd-trace-java instrumentation overhead on a Spring app.
- System under test: Spring app instrumented (or not) with dd-trace-java.
- **Workload: As many requests as possible by 5 concurrent users.**

---

## An non-repeatable benchmark

- Goal: Measuring dd-trace-java instrumentation overhead on a Spring app.
- System under test: Spring app instrumented (or not) with dd-trace-java.
- Workload: As many requests as possible by 5 concurrent users.
- **20 second warmup, 15 seconds of actual measurements.**

---

<!-- Speaker note: 1 measurement per second. Benchmarking harnesses and load generators often run several iterations to build a single sample. -->

<center>

![width:600](./assets/benchmark-design-experiment-1.svg)

</center>

---

<center>

![width:600](./assets/benchmark-design-experiment-1.svg)

Many <span class="hl">**false positives**</span> and **high coeff. of variation** (= standard deviation / mean) of <span class="hl">11.80%</span>.

</center>

---

<center>

![width:600](./assets/benchmark-design-experiment-1.svg)

Many <span class="hl">**false positives**</span> and **high coeff. of variation** (= standard deviation / mean) of <span class="hl">11.80%</span>.

**Are we running the benchmark long enough?**

</center>

---

<center>

![width:600](./assets/benchmark-design-experiment-2.svg)

</center>

---

<center>

![width:600](./assets/benchmark-design-experiment-2.svg)

**Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).**

<!-- The JVM compiles methods on-the-fly. Each method needs to be called enough times to hit the compilation threshold, then you wait for the compiler to finish. More methods + fewer CPUs = longer warmup. -->

</center>

---

<center>

![width:600](./assets/benchmark-design-experiment-2.svg)

Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).

**For how long should we run the benchmark?**

</center>

---

<div class="columns">

<div>

![width:600](./assets/benchmark-design-experiment-3-with-dotted-lines.svg)

</div>

<div style="padding-top: 100px;">
<div class="centered-table">

| # measurements | coeff. of variation |
| -------------- | ------------------- |
| 30             | 6.95%               |
| 60             | 5.23%               |
| 90             | 4.59%               |

</div>
</div>

</div>

---

<div class="columns">

<div>

![width:600](./assets/benchmark-design-experiment-3-with-dotted-lines.svg)

</div>

<div style="padding-top: 100px;">
<div class="centered-table">

| # measurements | coeff. of variation |
| -------------- | ------------------- |
| 30             | 6.95%               |
| 60             | 5.23%               |
| 90             | 4.59%               |

</div>
</div>

</div>

<center>

**Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).**

</center>

---

<div class="columns">

<div>

![width:600](./assets/benchmark-design-experiment-3-with-dotted-lines.svg)

</div>

<div style="padding-top: 100px;">
<div class="centered-table">

| # measurements | coeff. of variation |
| -------------- | ------------------- |
| 30             | 6.95%               |
| 60             | 5.23%               |
| 90             | 4.59%               |

</div>
</div>

</div>

<center>

Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).

**But what about inter-run variation?**

</center>

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/benchmark-design-kalibera-random-initial-state-effects.png)

_Impact of initial state on FFT benchmark results \[3\]_

</center>

---

<!-- _class: vcenter -->

<center>

![width:900](./assets/benchmark-design-experiment-4.svg)

</center>

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/benchmark-design-experiment-4-random-initial-state.svg)

</center>

---

<div class="columns">

<div>

<center>

![width:600](./assets/benchmark-design-experiment-4-random-initial-state.svg)

</center>

</div>

<div style="padding-top: 45px;">

<div class="centered-table">

| Run # | mean ± stddev   | coeff. of variation |
| ----- | --------------- | ------------------- |
| 1     | 20.08 ± 0.63 ms | 3.16%               |
| 2     | 20.63 ± 0.56 ms | 2.72%               |
| 3     | 20.31 ± 0.45 ms | 2.23%               |
| 4     | 20.19 ± 0.54 ms | 2.66%               |
| 5     | 20.26 ± 0.63 ms | 3.11%               |
| all   | 20.29 ± 0.60 ms | 2.94%               |

</div>

</div>

</div>

---

<div class="columns">

<div>

<center>

![width:600](./assets/benchmark-design-experiment-4-random-initial-state.svg)

</center>

</div>

<div style="padding-top: 45px;">

<div class="centered-table">

| Run # | mean ± stddev   | coeff. of variation |
| ----- | --------------- | ------------------- |
| 1     | 20.08 ± 0.63 ms | 3.16%               |
| 2     | 20.63 ± 0.56 ms | 2.72%               |
| 3     | 20.31 ± 0.45 ms | 2.23%               |
| 4     | 20.19 ± 0.54 ms | 2.66%               |
| 5     | 20.26 ± 0.63 ms | 3.11%               |
| all   | 20.29 ± 0.60 ms | 2.94%               |

</div>

</div>

</div>

<center>

**Tip #3: Rerun benchmarks multiple times to reduce inter-run variation (M ≥ 5).**

<!-- Cache, memory placement -->

</center>

---

Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).

Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).

Tip #3: Rerun benchmarks multiple times to reduce inter-run variation (M ≥ 5).

<br>

<center>

Coefficient of variation: <span class="hl">11.80% → **2.94%**</span>

</center>

---

Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).

Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).

Tip #3: Rerun benchmarks multiple times to reduce inter-run variation (M ≥ 5).

<br>

<center>

Coefficient of variation: <span class="hl">11.80% → **2.94%**</span>

</center>

<br>

**Tip #4: Use deterministic inputs.**

---

Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).

Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).

Tip #3: Rerun benchmarks multiple times to reduce inter-run variation (M ≥ 5).

<br>

<center>

Coefficient of variation: <span class="hl">11.80% → **2.94%**</span>

</center>

<br>

Tip #4: Use deterministic inputs.

**Tip #5: Use load generators that avoid the **coordinated omission** problem (e.g., k6).**

---

Tip #1: Run benchmarks for longer to uncover perturbations (e.g., warmup effects).

Tip #2: Collect enough samples to reduce intra-run variation (N ≥ 30).

Tip #3: Rerun benchmarks multiple times to reduce inter-run variation (M ≥ 5).

<br>

<center>

Coefficient of variation: <span class="hl">11.80% → **2.94%**</span>

</center>

<br>

Tip #4: Use deterministic inputs.

Tip #5: Use load generators that avoid the **coordinated omission** problem (e.g., k6).

<span class="comment">

Slow system → load generator slows down → artificially better latencies.

_Gil Tene, "How NOT to Measure Latency" \[4\]_

</span>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

# Interpreting Benchmark Results

---

<!-- footer: "Interpreting Benchmark Results" -->
<!-- _class: vcenter -->

<center>

![width:950](./assets/interpreting-results-timeseries-full.svg)

</center>

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/interpreting-results-timeseries-zoom.svg)

</center>

---

<!-- _class: vcenter -->

<center>

![width:850](./assets/interpreting-results-with-distributions.svg)

</center>

---

<!-- _class: vcenter -->

<center>

![width:850](./assets/interpreting-results-with-distributions.svg)

<div class="bottom-citation">

**How can we tell if the difference is big enough?**

</div>

</center>

---

<!-- _class: vcenter -->

<center>

![width:700](./assets/math-vs-intuition-meme-distracted-boyfriend.png)

</center>

---

<!-- _class: vcenter -->

<center>

<span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

t > critical value

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

t > critical value

false positive rate

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

t > critical value

α = false positive rate

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

t > critical value(α)

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

$$t = \frac{\bar{x}_1 - \bar{x}_2}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}$$

t > critical value(α)

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

$$t = \frac{\bar{x}_1 - \bar{x}_2}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}$$

t > critical value(α)

$$t > t_{\alpha, \text{df}}$$

</center>

---

<!-- _class: vcenter -->

<center>

t = <span class="fraction"><span class="num">how big the difference is</span><span class="den">how big the noise is</span></span>

$$t = \frac{\bar{x}_1 - \bar{x}_2}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}$$

t > critical value(α)

$$t > t_{\alpha, \text{df}}$$

<span class="hl">Hypothesis test (t-test).</span>

</center>

---

## Another approach: changepoint detection

<!-- footer: "" -->

<center>

![width:800](./assets/fosdem-schedule.png)

</center>

---

<!-- footer: "Interpreting Benchmark Results" -->

<span class="comment">

Tip #1: Long enough benchmarks.
Tip #2: Enough samples (N ≥ 30).
Tip #3: Enough runs (M ≥ 5).
Tip #4: Deterministic inputs.
Tip #5: Avoid coordinated omission.

</span>

**Tip #6: Use hypothesis testing to determine if improvements/regressions are statistically significant.**

---

<span class="comment">

Tip #1: Long enough benchmarks.
Tip #2: Enough samples (N ≥ 30).
Tip #3: Enough runs (M ≥ 5).
Tip #4: Deterministic inputs.
Tip #5: Avoid coordinated omission.
Tip #6: Use hypothesis testing.

</span>

<center>

**But what about inter-experiment variation?**

</center>

---

<span class="comment">

Tip #1: Long enough benchmarks.
Tip #2: Enough samples (N ≥ 30).
Tip #3: Enough runs (M ≥ 5).
Tip #4: Deterministic inputs.
Tip #5: Avoid coordinated omission.
Tip #6: Use hypothesis testing.

</span>

<center>

But what about inter-experiment variation?

**Tip #7: Control your benchmarking environment.**

</center>

---

<span class="comment">

Tip #1: Long enough benchmarks.
Tip #2: Enough samples (N ≥ 30).
Tip #3: Enough runs (M ≥ 5).
Tip #4: Deterministic inputs.
Tip #5: Avoid coordinated omission.
Tip #6: Use hypothesis testing.

</span>

<center>

But what about inter-experiment variation?

**<span class="replace"><span class="old">Tip #7</span><span class="new">Tip #0</span></span>: Control your benchmarking environment.**

</center>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

# How to Control Your Benchmarking Environment

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/researchers.png)

</center>

---

<!-- _class: vcenter -->

<center>

![width:1000](./assets/researchers-cern-to-gran-sasso-neutrino-beam.png)

_\[5\]_

</center>

---

<!-- _class: vcenter -->

<center>

<div class="big">
5 years

~€100M 💸

</div>

_[6, 7]_

</center>

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/particles-break-light-speed-headline.png)

</center>

---

<!-- _class: vcenter -->

<center>

![width:600](./assets/opera-loose-cable-upscaled.png)

_Loose fiber optic cable that caused the measurement error \[8\]_

</center>

---

<!-- _class: vcenter -->

<center>

<div class="medium">

Most of us aren't building 730km tunnels.

</div>

_But we deal with "loose cables" every day when measuring software performance._

</center>

---

<!-- _class: vcenter -->
<!-- footer: "How to Control Your Benchmarking Environment" -->

<div class="centered-table">

| Layer       | Sources of Noise                                                                | Mitigations                                                        |
| ----------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| External    | Network<br>Temperature<br>Vibration<br>Virtualization                           | Use dedicated on-prem hardware<br>Use bare metal cloud instances   |
| Application | Memory layout<br>Compilation/linking                                            | Set up fixed builds (e.g., disable ASLR)                           |
| Kernel      | Scheduling<br>Caching                                                           | Set CPU affinity<br>Set process priority<br>Warm up or drop caches |
| CPU         | Simultaneous multithreading (SMT) contention<br>Dynamic frequency scaling (DFS) | Disable SMT<br>Disable DFS                                         |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer                            | Sources of Noise                                                                                        | Mitigations                                                                                |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| <span class="hl">External</span> | Network<br>Temperature<br>Vibration<br><span class="hl">Virtualization</span>                           | Use dedicated on-prem hardware<br><span class="hl">Use bare metal cloud instances</span>   |
| Application                      | Memory layout<br>Compilation/linking                                                                    | Set up fixed builds (e.g., disable ASLR)                                                   |
| <span class="hl">Kernel</span>   | <span class="hl">Scheduling<br>Caching</span>                                                           | <span class="hl">Set CPU affinity<br>Set process priority<br>Warm up or drop caches</span> |
| <span class="hl">CPU</span>      | <span class="hl">Simultaneous multithreading (SMT) contention<br>Dynamic frequency scaling (DFS)</span> | <span class="hl">Disable SMT<br>Disable DFS</span>                                         |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer    | Sources of Noise | Mitigations                    |
| -------- | ---------------- | ------------------------------ |
| External | Virtualization   | Use bare metal cloud instances |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer    | Sources of Noise | Mitigations                    |
| -------- | ---------------- | ------------------------------ |
| External | Virtualization   | Use bare metal cloud instances |

</div>

<center>

**Noisy neighbor problem.**

</center>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer    | Sources of Noise | Mitigations                    |
| -------- | ---------------- | ------------------------------ |
| External | Virtualization   | Use bare metal cloud instances |

</div>

<center>

Noisy neighbor problem.

**Kernel- and CPU-layer mitigations require bare metal access.**

</center>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer  | Sources of Noise      | Mitigations                                                        |
| ------ | --------------------- | ------------------------------------------------------------------ |
| Kernel | Scheduling<br>Caching | Set CPU affinity<br>Set process priority<br>Warm up or drop caches |

</div>

```bash
# Set CPU affinity
taskset -c 0 ./benchmark

# Set process priority
nice -n -5 ./benchmark

# Drop filesystem cache
echo 3 > /proc/sys/vm/drop_caches && sync
```

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                | Mitigations                |
| ----- | ------------------------------------------------------------------------------- | -------------------------- |
| CPU   | Simultaneous multithreading (SMT) contention<br>Dynamic frequency scaling (DFS) | Disable SMT<br>Disable DFS |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | <span class="hl">Simultaneous multithreading (SMT) contention</span><br>Dynamic frequency scaling (DFS) | <span class="hl">Disable SMT</span><br>Disable DFS |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | <span class="hl">Simultaneous multithreading (SMT) contention</span><br>Dynamic frequency scaling (DFS) | <span class="hl">Disable SMT</span><br>Disable DFS |

</div>

<center>

**Multiple _hardware threads_ share the same core.**

</center>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | <span class="hl">Simultaneous multithreading (SMT) contention</span><br>Dynamic frequency scaling (DFS) | <span class="hl">Disable SMT</span><br>Disable DFS |

</div>

<center>

Multiple _hardware threads_ share the same core.

</center>

```bash
# Disable SMT
echo off > /sys/devices/system/cpu/smt/control
```

---

## What's the impact of disabling SMT?

<center>

bare metal, dynamic frequency scaling (DFS) disabled

</center>

---

## What's the impact of disabling SMT?

<center>

bare metal, dynamic frequency scaling (DFS) disabled
**2 CPU-bound tasks, <span class="hl-blue">same core</span> vs. <span class="hl-orange">separate cores</span>**

</center>

---

## What's the impact of disabling SMT?

<center>

bare metal, dynamic frequency scaling (DFS) disabled
**2 CPU-bound tasks, <span class="hl-blue">same core</span> vs. <span class="hl-orange">separate cores</span>**

</center>

<center>

![width:550](./assets/environment-control-smt-experiment.svg)

</center>

---

## What's the impact of disabling SMT?

<center>

bare metal, dynamic frequency scaling (DFS) disabled
**2 CPU-bound tasks, <span class="hl-blue">same core</span> vs. <span class="hl-orange">separate cores</span>**

</center>

<div class="columns">

<div>

<center>

![width:450](./assets/environment-control-smt-experiment.svg)

</center>

</div>

<!-- To align with the graph's borders -->
<div style="padding-top: 43px;">

| Task     | mean ± stddev       | coeff. of variation |
| -------- | ------------------- | ------------------- |
| smt-1    | 1537.64 ± 367.29 ms | 23.887 %            |
| smt-2    | 1536.88 ± 366.84 ms | 23.869 %            |
| no-smt-1 | 737.37 ± 0.32 ms    | 0.044 %             |
| no-smt-2 | 737.93 ± 1.74 ms    | 0.235 %             |

</div>

</div>

---

## What's the impact of disabling SMT?

<center>

bare metal, dynamic frequency scaling (DFS) disabled
**2 CPU-bound tasks, <span class="hl-blue">same core</span> vs. <span class="hl-orange">separate cores</span>**

</center>

<div class="columns">

<div>

<center>

![width:450](./assets/environment-control-smt-experiment.svg)

</center>

</div>

<!-- To align with the graph's borders -->
<div style="padding-top: 43px;">

| Task     | mean ± stddev       | coeff. of variation                    |
| -------- | ------------------- | -------------------------------------- |
| smt-1    | 1537.64 ± 367.29 ms | <span class="hl-blue">23.887 %</span>  |
| smt-2    | 1536.88 ± 366.84 ms | <span class="hl-blue">23.869 %</span>  |
| no-smt-1 | 737.37 ± 0.32 ms    | <span class="hl-orange">0.044 %</span> |
| no-smt-2 | 737.93 ± 1.74 ms    | <span class="hl-orange">0.235 %</span> |

</div>

</div>

<div style="transform: translateY(-30px);">

<center>

**<span class="hl">100x less variation</span>**

</center>

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | Simultaneous multithreading (SMT) contention<br><span class="hl">Dynamic frequency scaling (DFS)</span> | Disable SMT<br><span class="hl">Disable DFS</span> |

</div>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | Simultaneous multithreading (SMT) contention<br><span class="hl">Dynamic frequency scaling (DFS)</span> | Disable SMT<br><span class="hl">Disable DFS</span> |

</div>

<center>

**Dynamic frequency scaling (DFS) adjusts the CPU frequency to match the workload.**

</center>

---

<!-- _class: vcenter -->

<div class="centered-table">

| Layer | Sources of Noise                                                                                        | Mitigations                                        |
| ----- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| CPU   | Simultaneous multithreading (SMT) contention<br><span class="hl">Dynamic frequency scaling (DFS)</span> | Disable SMT<br><span class="hl">Disable DFS</span> |

</div>

<center>

Dynamic frequency scaling (DFS) adjusts the CPU frequency to match the workload.

</center>

```bash
# Pin clock rate
echo 2500000 > /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq

# Set scaling governor to "performance"
echo performance > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable frequency boosting (Turbo-Boost, Intel CPUs only)
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
```

---

## What's the impact of disabling DFS?

<center>

bare metal, simultaneous multithreading (SMT) disabled

</center>

---

## What's the impact of disabling DFS?

<center>

bare metal, simultaneous multithreading (SMT) disabled
**Varying number of CPU-bound tasks, same core, <span class="hl-blue">DFS on</span> vs. <span class="hl-orange">DFS off</span>**

</center>

---

## What's the impact of disabling DFS?

<center>

bare metal, simultaneous multithreading (SMT) disabled
**Varying number of CPU-bound tasks, same core, <span class="hl-blue">DFS on</span> vs. <span class="hl-orange">DFS off</span>**

</center>

<center>

![width:550](./assets/environment-control-dfs-experiment.svg)

</center>

---

## What's the impact of disabling DFS?

<center>

bare metal, simultaneous multithreading (SMT) disabled
**Varying number of CPU-bound tasks, same core, <span class="hl-blue">DFS on</span> vs. <span class="hl-orange">DFS off</span>**

</center>

<div class="columns">

<div>

<center>

![width:450](./assets/environment-control-dfs-experiment.svg)

</center>

</div>

<div style="padding-top: 35px;">

| Task     | mean ± stddev     | coeff. of variation |
| -------- | ----------------- | ------------------- |
| dfs-1    | 533.97 ± 2.046 ms | 0.383 %             |
| dfs-8    | 578.67 ± 0.287 ms | 0.050 %             |
| no-dfs-1 | 738.18 ± 0.306 ms | 0.041 %             |
| no-dfs-8 | 739.18 ± 0.351 ms | 0.047 %             |

</div>

</div>

---

## What's the impact of disabling DFS?

<center>

bare metal, simultaneous multithreading (SMT) disabled
**Varying number of CPU-bound tasks, same core, <span class="hl-blue">DFS on</span> vs. <span class="hl-orange">DFS off</span>**

</center>

<div class="columns">

<div>

<center>

![width:450](./assets/environment-control-dfs-experiment.svg)

</center>

</div>

<div style="padding-top: 35px;">

| Task     | mean ± stddev     | coeff. of variation                    |
| -------- | ----------------- | -------------------------------------- |
| dfs-1    | 533.97 ± 2.046 ms | <span class="hl-blue">0.383 %</span>   |
| dfs-8    | 578.67 ± 0.287 ms | 0.050 %                                |
| no-dfs-1 | 738.18 ± 0.306 ms | <span class="hl-orange">0.041 %</span> |
| no-dfs-8 | 739.18 ± 0.351 ms | 0.047 %                                |

</div>

</div>

<div style="transform: translateY(-30px);">

<center>

**<span class="hl">10x less variation</span>**

</center>

</div>

---

<!-- _class: vcenter -->
<!-- Speaker note: These are not all the tweaks that we do. -->

<center>

![width:200](./assets/dmytro.jpeg)

_SMT and DFS experiments by [Dmytro Yurchenko](https://www.linkedin.com/in/dmytro-y-/)_

<br>

_CPU-level tweaks at Denis Bakhvalov's_
_"Performance Analysis and Tuning on Modern CPUs" \[1\]_

</center>

---

<!-- _class: vcenter -->

<center>

| Layer    | Sources of Noise | Mitigations                   |
| -------- | ---------------- | ----------------------------- |
| External | Vibration        | Don't shout in the datacenter |

</center>

---

<!-- _class: vcenter -->

<center>

_[🔗 Shouting in the Datacenter](https://www.youtube.com/watch?v=tDacjrSCeq4)_

![width:900](./assets/brendan-gregg-shouting-at-datacenter.png)

</center>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

# Integrating Benchmarks Into Your Workflows

---

<!-- footer: "Integrating Benchmarks Into Your Workflows" -->

## Architecture Overview

<center>

![width:1000](./assets/bp-arch.png)

</center>

---

## Feedback Loop

<center>

![bg contain](./assets/bp-feedback-flow.png)

</center>

<!--
</span>

_Catch regressions before they merge_

</center>

<div class="bottom-citation">

_Benchmarks should be locally reproducible for developers to take action._

</div>
-->

---

## Feedback Loop

<center>

![bg contain](./assets/bp-feedback-flow-0.png)

</center>

---

## Feedback Loop

<center>

![bg contain](./assets/bp-feedback-flow-1.png)

</center>

---

## Feedback Loop

<center>

![bg contain](./assets/bp-feedback-flow-2.png)

</center>

---

## Feedback Loop

<center>

![bg contain](./assets/bp-feedback-flow-3.png)

</center>

---

## Feedback Loop

<center>

![width:1000](./assets/bp-slo.png)

</center>

---

## Open Source Tools

**Start running benchmarks continuously today:**

- [bencher.dev](https://bencher.dev/) - Continuous benchmarking platform
- [hyperfine](https://github.com/sharkdp/hyperfine) - CLI benchmark tool
- [github-action-benchmark](https://github.com/benchmark-action/github-action-benchmark) - GitHub Action
- [chronologer](https://github.com/dandavison/chronologer) - Benchmark tracking

<br>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

# Conclusion

---

<!-- footer: "Conclusion" -->

## Key Takeaways

1. **Control your benchmarking environment**
   Bare metal, isolation, disable SMT, disable DFS

---

## Key Takeaways

1. **Control your benchmarking environment**
   Bare metal, isolation, disable SMT, disable DFS

2. **Design your benchmarks**
   Representative and repeatable

---

## Key Takeaways

1. **Control your benchmarking environment**
   Bare metal, isolation, disable SMT, disable DFS

2. **Design your benchmarks**
   Representative and repeatable

3. **Interpret benchmark results**
   Statistics matter (hypothesis testing)

---

## Key Takeaways

1. **Control your benchmarking environment**
   Bare metal, isolation, disable SMT, disable DFS

2. **Design your benchmarks**
   Representative and repeatable

3. **Interpret benchmark results**
   Statistics matter (hypothesis testing)

4. **Integrate benchmarks into your workflows**
   Run continuously, catch regressions early

---

<!-- _class: vcenter -->

<center>

![width:900](./assets/brendan-gregg-shouting-at-datacenter.png)

**Don't shout in the datacenter**

</center>

---

<!-- _class: vcenter invert -->
<!-- footer: "" -->

<style scoped>
.columns {
    height: 100%;
    align-items: center;
}
.columns > div:first-child {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

<div class="columns">

<div>

# Thanks!

</div>
<div>

![width:350](./assets/slides_qr_code.png)

</div>

</div>

---

<style scoped>
p { font-size: 0.5em; line-height: 1.4; }
</style>

# References

\[1\] Bakhvalov, D. (2020). _Performance Analysis and Tuning on Modern CPUs_. <https://github.com/dendibakh/perf-book>. Accessed Jan 2026.
\[2\] Leiserson, C. et al. (2020). "There's plenty of room at the Top: What will drive computer performance after Moore's law?" _Science_, 368(6495).
\[3\] Kalibera, T., Bulej, L., and Tuma, P. (2005). "Benchmark Precision and Random Initial State." In _Proceedings of the International Symposium on Performance Evaluation of Computer and Telecommunication Systems (SPECTS)_, pages 182-196. SCS.
\[4\] Tene, G. (2015). "How NOT to Measure Latency." <https://www.youtube.com/watch?v=lJ8ydIuPFeU>. Accessed Jan 2026.
\[5\] Universität Münster. "Neutrino oscillations in the neutrino beam from CERN to Gran Sasso." <https://www.uni-muenster.de/Physik.KP/en/AGFrekers/forschung/opera.html>. Accessed Jan 2026.
\[6\] CERN. (1999). "From Geneva to Gran Sasso in 2.5 milliseconds!". <https://home.cern/news/press-release/cern/geneva-gran-sasso-25-milliseconds>. Accessed Jan 2026.
\[7\] Wikipedia. "OPERA experiment." <https://en.wikipedia.org/wiki/OPERA_experiment>. Accessed Jan 2026.
\[8\] Strassler, M. (2012). "OPERA: What Went Wrong." <https://profmattstrassler.com/articles-and-posts/particle-physics-basics/neutrinos/neutrinos-faster-than-light/opera-what-went-wrong/>. Accessed Jan 2026.
\[9\] Gregg, B. (2020). _Systems Performance: Enterprise and the Cloud_, 2nd ed. Addison-Wesley. Chapter 2.8, "Visualizations."
\[10\] Valles, A. (2009). "Performance Insights to Intel Hyper-Threading Technology." <https://web.archive.org/web/20150217050949/https://software.intel.com/en-us/articles/performance-insights-to-intel-hyper-threading-technology/>. Accessed Jan 2026.
\[11\] Gregg, B. (2014). "Frequency Trails: Outliers." <https://www.brendangregg.com/FrequencyTrails/outliers.html#Causes>. Accessed Jan 2026.
\[12\] Gregg, B. (2020). "Systems Performance: Enterprise and the Cloud.", p. 233, "P-states and C-states."
\[13\] Humenay, E., Tarjan, D., and Skadron, K. (2007). "Impact of Process Variations on Multicore Performance Symmetry."
\[14\] Linux Kernel Documentation. "CPUFreq Governors." <https://www.kernel.org/doc/Documentation/cpu-freq/governors.txt>. Accessed Jan 2026.
\[15\] ArchWiki. "CPU frequency scaling." <https://wiki.archlinux.org/title/CPU_frequency_scaling>. Accessed Jan 2026.
\[16\] Intel. "Intel Server Board and System Products Update on Intel Turbo Boost Technology Support with Low Power Intel Xeon Processor 3400/5500/5600 Series." <https://cdrdv2-public.intel.com/840590/white_paper_turbo_boost_on_low_power_processor.pdf>. Accessed Jan 2026.
