<!-- @format -->

# topapi

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/ElianHugh/topapi/workflows/R-CMD-check/badge.svg)](https://github.com/ElianHugh/topapi/actions)

<!-- badges: end -->

Pseudo-API wrapper for the TOP factor dataset. Implements helper functions for interacting with the TOP dataset. Rather than manually downloading the dataset, the **topapi** package keeps the dataset in memory, meaning the data is both easily accessible and always up to date.

## Installation

Requires my {[enumr](https://github.com/ElianHugh/enumr)} package:

```r
install.packages("enumr", repos = 'https://elianhugh.r-universe.dev')
```

You can install the released version of topapi from [R-universe](https://r-universe.dev/organizations/) with:

```r
install.packages("topapi", repos = 'https://elianhugh.r-universe.dev')
```

## Examples

```r
library(topapi)

# Get data by journal name
journal_name("Autoimmunity Reviews")

# Get data by journal name, with sub-string matching
journal_name("Autoimmunity Reviews", exact_match = FALSE)

# Get data by journal ISSN
journal_issn("1568-9972")
## or
journal_issn(15689972)

# Get data by journal issn, substring matching
journal_issn("1568", exact_match = FALSE)

# Get data by publisher
publisher_name("Elsevier")

# Get data by publisher, substring matching
publisher_name("Else", exact_match = FALSE)
```

## Code of Conduct

Please note that the topapi project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
