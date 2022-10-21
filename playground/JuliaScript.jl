using DataFrames, CSV, BenchmarkTools

df = CSV.read("data\\filtered_opm_df.csv.gz", DataFrame);
first(df, 5)
describe(df)
size(df)

varinfo(r"df")
dropmissing(df)