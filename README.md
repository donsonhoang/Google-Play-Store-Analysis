# Google Play Store Market Analysis

An end-to-end data analysis of the Google Play Store: ~9,700 unique apps and 60K+ user reviews, exploring what drives app ratings, installs, and pricing across categories.

Built as a portfolio project to demonstrate a full data-analyst workflow — data cleaning, exploratory data analysis, SQL querying, and sentiment analysis — using Python.

## Tools

Python · Jupyter Notebook · pandas · NumPy · Matplotlib · SQL (SQLite)

## Dataset

[Google Play Store Apps](https://www.kaggle.com/datasets/lava18/google-play-store-apps) (Kaggle, CC BY 3.0 license):

- `googleplaystore.csv` — 10,841 apps x 13 attributes (category, rating, reviews, size, installs, price, content rating, etc.)
- `googleplaystore_user_reviews.csv` — 64,295 user reviews with pre-labeled sentiment (Positive / Negative / Neutral) and sentiment polarity scores

## Project Structure

```
play-store-analysis/
├── README.md
├── requirements.txt
├── data/
│   ├── googleplaystore.csv              # raw app metadata
│   ├── googleplaystore_user_reviews.csv # raw user reviews
│   ├── cleaned_googleplaystore.csv      # output of the cleaning step
│   └── license.txt
├── notebooks/
│   └── google_play_store_analysis.ipynb # main analysis notebook
├── sql/
│   └── queries.sql                      # standalone SQL queries used in the analysis
└── images/                              # exported chart PNGs
```

## What's in the Notebook

1. **Data loading** — read both CSVs, inspect shape and structure.
2. **Data cleaning** — convert `Installs`, `Price`, `Reviews`, and `Size` from text to numeric; parse dates; drop a malformed row and duplicate app entries; handle missing/invalid ratings.
3. **Exploratory data analysis (pandas/NumPy)** — descriptive statistics, category distribution, free vs. paid split, rating distribution, and a correlation matrix across numeric features.
4. **SQL analysis** — the cleaned data is loaded into an in-memory SQLite database and queried directly with SQL (category rankings, top installed apps, free vs. paid comparison, install totals by category).
5. **Sentiment analysis** — user reviews are aggregated per app and merged with the ratings data to test whether review sentiment tracks with star ratings.
6. **Key insights & conclusion** — findings summarized in plain language, with ideas for extending the analysis.

## Key Findings

- After cleaning, the dataset contains **9,658 unique apps**.
- **92.2%** of apps are free. Free apps average **234,270 reviews** vs. just **8,725** for paid apps — a huge engagement gap — while average ratings are close (4.17 free vs. 4.26 paid).
- **Family** is the most saturated category (1,831 apps), but **Games** drive the most total reach at **13.9 billion** cumulative installs.
- The average app rating is **4.17/5** (median 4.3), and ratings skew right, clustering between 4.0–4.5. **Events** is the highest-rated category (4.44 avg) among categories with 30+ apps.
- **Google Play Books** is the single most-installed app in the dataset at **1 billion+** installs.
- Across 816 apps with review text, average review sentiment polarity correlates with star rating at **r = 0.26** — a weak-to-moderate positive relationship, suggesting star ratings and written review sentiment capture related but distinct signals.
- **Events** also has the most positive average review sentiment (0.38 polarity) among categories with 5+ apps.

## How to Run

```bash
pip install -r requirements.txt
jupyter notebook notebooks/google_play_store_analysis.ipynb
```

The notebook runs top to bottom with no external dependencies beyond the packages in `requirements.txt` — all data is local and all SQL runs against an in-memory SQLite database created at runtime.

## Possible Extensions

- Predict app rating from category, price, size, and installs using a regression/classification model.
- Apply proper NLP (TF-IDF, topic modeling) to the raw review text instead of relying on pre-labeled sentiment.
- Analyze rating/install trends over time using the `Last Updated` field.
- Turn the SQL queries into an interactive dashboard (e.g., Plotly Dash or Tableau).

## License

Dataset licensed under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/) (see `data/license.txt`). Analysis code is free to reuse.
