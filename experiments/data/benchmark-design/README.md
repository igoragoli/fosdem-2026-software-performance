# Benchmark Design Experiments

Data from dd-trace-java load benchmarks demonstrating progressive improvements in benchmark design.

| File | n (measurements) | m (runs) | w (warmup s) | Description |
|------|------------------|----------|--------------|-------------|
| 1.json | 15 | 1 | 20 | Original: few measurements, high variation |
| 2.json | 300 | 1 | 20 | More measurements, reveals warmup effects |
| 3.json | 100 | 1 | 160 | Longer warmup, steady-state measurements |
| 4.json | 30 | 5 | 160 | Multiple runs, accounts for inter-run variation |

Files with `-warmup` suffix include the warmup period data; files without it have warmup excluded.
