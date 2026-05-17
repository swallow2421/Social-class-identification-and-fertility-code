# Social Class Identification Discrepancy and Fertility Intention: Evidence from China

This repository provides the Stata code used for the empirical analysis in:

> Xu, W., Lopez, R. A., Shen, A., & Zhu, C. (2026). **Social class identification discrepancy and fertility intention: Evidence from China**. *Acta Psychologica*, 266, 106991. https://doi.org/10.1016/j.actpsy.2026.106991

## Overview

This study examines whether discrepancies between subjective social class identification and objective socioeconomic status are associated with fertility intentions in China. Using data from the 2017–2021 China General Social Survey (CGSS), the paper finds that, relative to individuals who underestimate their social class, individuals who overestimate their social class and those whose subjective and objective class positions are consistent report significantly higher fertility intentions. The analysis also examines fertility behavior, second-child intentions, potential mechanisms, robustness checks, instrumental-variable estimates, and heterogeneity across population groups.

The code in this repository reproduces the main regression tables and appendix results reported in the paper.

## Repository contents

A suggested repository structure is:

```text
.
├── README.md
├── code/
│   └── acta_psychologica_replication.do
├── data/
│   └── jieceng.dta              # Not included in the public repository
└── results/
    ├── table2_*.rtf
    ├── table3_*.rtf
    ├── table4_*.rtf
    ├── table5_*.rtf
    ├── table6_1_*.rtf
    ├── table6_2_*.rtf
    └── appendix1_*.rtf
```

The raw and cleaned CGSS data are not included in this repository because of data-use restrictions. Users who wish to reproduce the results should obtain the CGSS data from the official data provider and construct the analysis dataset following the definitions described in the paper.

## Data

The analysis uses the China General Social Survey (CGSS) for 2017, 2018, and 2021. The final estimation sample in the paper is restricted to respondents aged 18–45 and contains 12,220 observations.

The main analysis dataset used by the code is:

```text
data/jieceng.dta
```

In the original code, the working directory is set as:

```stata
global root "D:/jieceng"
global d    $root/Data
global r    $root/Results
```

Before running the code, please modify these paths to match your local folder structure.

## Software requirements

The code is written in Stata. Stata 16 or newer is recommended.

The following user-written Stata packages are required:

```stata
ssc install estout, replace
ssc install ivreg2, replace
```

The commands `reg`, `tobit`, and `margins` are built-in Stata commands.

## Main variables

The key variables used in the replication code include:

| Variable | Description |
|---|---|
| `child` | Fertility intention, measured as the intended number of children |
| `jie` | Subjective socioeconomic status / subjective social class identification |
| `diwei` | Objective socioeconomic status |
| `upbias` | Indicator for upward social class identification discrepancy |
| `consistent` | Indicator for consistent subjective and objective social class identification |
| `tfertility` | Fertility behavior |
| `twochild` | Indicator for having two children |
| `erhai` | Intention to have a second child |
| `happiness` | Subjective well-being |
| `trust` | Social trust |
| `fair` | Perceived fairness |
| `oldjie` | Social class identification ten years earlier, used as an instrumental variable |
| `sm` | Province code |
| `year` | Survey year |

The main control variables are defined in the global macro:

```stata
global control gender age age2 health dang married nation gya guanli worktime parents only_child size ferboy faincome
```

These controls capture demographic characteristics, socioeconomic factors, institutional factors, family structure, and cultural norms.

## Empirical specifications

The code estimates province- and year-fixed-effects models with standard errors clustered at the province level. The baseline specification can be summarized as:

```stata
reg child upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
```

The reference group is respondents with downward social class identification discrepancy.

## How to run

1. Clone or download this repository.
2. Obtain the CGSS data and prepare the cleaned analysis dataset as `jieceng.dta`.
3. Place `jieceng.dta` in the `data/` folder.
4. Open `code/acta_psychologica_replication.do` in Stata.
5. Update the directory paths at the beginning of the do-file.
6. Run the full do-file.

Example:

```stata
cd "YOUR_LOCAL_REPOSITORY_PATH"
do "code/acta_psychologica_replication.do"
```

The output tables will be saved in the `results/` folder as RTF files.

## Output tables

The do-file generates the following outputs:

| Output file | Corresponding analysis |
|---|---|
| `table2_*.rtf` | Association between subjective/objective SES and fertility intention |
| `table3_*.rtf` | Baseline association between social class identification discrepancy and fertility intention |
| `table4_*.rtf` | Fertility behavior, second-child outcomes, and potential mechanisms |
| `appendix1_*.rtf` | Robustness checks |
| `table5_*.rtf` | Instrumental-variable analysis |
| `table6_1_*.rtf` | Heterogeneity by gender and age group |
| `table6_2_*.rtf` | Heterogeneity by hukou status, gender-inequality belief, and rice-growing region |

## Notes on reproducibility

The public repository contains the replication code but not the restricted CGSS data. Therefore, the code will not run directly unless the user has access to the required data and has constructed the variables according to the paper.

To improve reproducibility, users are encouraged to:

- keep the folder names `code/`, `data/`, and `results/`;
- store all generated tables in `results/`;
- keep the original variable names used in the do-file;
- document any changes to sample restrictions or variable construction;
- use the same sample restriction as the paper: respondents aged 18–45.

## Citation

If you use this code, please cite the paper:

```bibtex
@article{xu2026social,
  title   = {Social class identification discrepancy and fertility intention: Evidence from China},
  author  = {Xu, Wenyan and Lopez, Rigoberto A. and Shen, Ao and Zhu, Chen},
  journal = {Acta Psychologica},
  volume  = {266},
  pages   = {106991},
  year    = {2026},
  doi     = {10.1016/j.actpsy.2026.106991}
}
```

## License

Please see the repository license file for terms of use. The article is published by Elsevier as an open-access article under the CC BY-NC license. The code license should be specified separately by the repository owner.

## Contact

For questions about the code or replication materials, please contact:

**Wenyan Xu**  
College of Economics and Management, China Agricultural University  
Email: xuwenyan@cau.edu.cn
