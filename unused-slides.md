# Unused Slides

Slides that didn't make the final cut. May contain useful content for future talks.

---

<!-- _class: vcenter -->

# There will be dragons! 🐉

<span class="comment">
Ignore the slides after this. It's like a junkyard.
There might be some useful stuff to be salvaged there, but don't expect anything too polished.
</span>

<!-- Agenda -->

---

How to:

1. Control your benchmarking environment.
2. Design your benchmarks.
3. Interpret benchmark results.
4. Integrate benchmarks into your workflows.

<!-- Hypothesis testing slides -->

---

## Hypothesis test

**If t > critical value, reject the null hypothesis.**

---

## Hypothesis test

If t > critical value, reject the null hypothesis.

**Null hypothesis: no difference.**

---

## Hypothesis test

If t > critical value, reject the null hypothesis.

Null hypothesis: no difference.

**Alternative hypothesis: enough difference.**

---

## Hypothesis test

If t > critical value, reject the null hypothesis.

Null hypothesis: no difference.

Alternative hypothesis: enough difference.

**t, or t-statistic: difference/noise.**

---

## Hypothesis test

If t > critical value, reject the null hypothesis.

Null hypothesis: no difference.

Alternative hypothesis: enough difference.

t, or t-statistic: difference/noise.

**Critical value: threshold based on your tolerance for false positives.**

---

## Hypothesis test

If t > critical value, reject the null hypothesis.

Null hypothesis: no difference.

Alternative hypothesis: enough difference.

t, or t-statistic: difference/noise.

Critical value: threshold based on your tolerance for false positives.

**In practice, we use the p-value: <span class="hl">p < α</span>**

- **p-value:** probability of seeing this result if there's no real difference.
- **α:** false positive rate you're willing to tolerate.

---

<!-- _class: vcenter -->

```python
from scipy import stats

alpha = 0.05
t_stat, p_value = stats.ttest_ind(before, after)

if p_value < alpha:
    print("Statistically significant difference")
```

---

## Choosing α

<span class="hl">**α = 0.05**</span> (5%) is a common threshold for false positives.

Confidence level = 1 - α = 95%

---

## Choosing α

α = 0.05 (5%) is a common threshold for false positives.

Confidence level = 1 - α = 95%

**Trade-off**

- **Lower α (1%):** <span class="hl">Fewer false positives</span>, fewer detections.
- **Higher α (10%):** More false positives, <span class="hl">more detections</span>.

---
