using DataFrames, CSV, BenchmarkTools

df = CSV.read("data\\filtered_opm_df.csv.gz", DataFrame);
first(df, 5)

varinfo(r"df")
