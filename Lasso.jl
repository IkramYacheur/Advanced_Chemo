@sk_import linear_model:Lasso

data = CSV.read("/Users/ikram/Documents/Master/March-May 2022/Advanced Chemometrics and Statistics/Project /toxicity_data_fish_desc.csv", DataFrame)
descr = describe(data)

y = data[:, 6]
x = data[:, 8:end]

namen, x = remove_shit(x);
x = Matrix(x)
namen = namen

x_train, x_test, y_train, y_test = train_test_split(x,y)
tmp = Vector{Float64}(undef, length(collect(0.1:0.1:1)))
loop_vector = collect(0.01:0.01:0.1)
for i in eachindex(loop_vector)
    Model = Lasso(random_state=42, alpha=loop_vector[i], max_iter=5000)
    Model.fit(x_train,y_train)
    Model.score(x_train, y_train)
    tmp[i] = Model.score(x_test, y_test)
end
tmp


##Test
@sk_import linear_model:LassoCV
@sk_import datasets:make_regression
x = x .- mean(x,dims = 1)
x_ = x./(std(x, dims=1))
y = y .- mean(y,dims = 1)
y_ = y/(std(y))
reg = LassoCV(cv=2, random_state=42, max_iter=2500).fit(x_train, y_train)
reg.score(x_test, y_test)

It doesnt work

overleaf latex 
