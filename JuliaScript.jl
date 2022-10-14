using DataFrames, CSV

df = CSV.read("KR\\filtered_opm_df.csv.gz", DataFrame);
first(df, 5)

varinfo(r"df")

completecases()