# Project 2 - 3D Visualization

This project analyzes the check-out and check-in data for books related to fiber and textile crafts. I looked into 4 keywords primarily, "Crochet", one of its sub-form "Amigurumi", "Macrame", and its sub-form "Friendship Bracelet". Then, I queried for book records with titles containing these keywords, and measured the length of time each book spent outside the Seattle Public Library. Additionally, I aggregated the number of check-outs and check-ins that occurred for each of the four categories of books on each day to produce frequency datasets.

The queried data contains records from 2005 until the first two weeks of February 2023. The year-month-day timestamp data maps each record to a point in the 3D space, with days of a month organized along the x-axis, and months and years organized along the z-axis, with the height of each curve (along -y) determined by the number of days each book spent outside the SPL. For the aggregated frequency data, I visualized the number of check-outs and check-ins on each day as spheres, with the size of each sphere corresponding to check-out and check-in counts.

The GUI allows the user to navigate the 3D space and includes toggles to show or hide components of the visualization, revealing patterns in the dataset.

[Read more about the project](https://cold-chocolate.notion.site/Project-2-3D-Visualization-write-up-75167912134c4a619f6728e9ce2c97f6)