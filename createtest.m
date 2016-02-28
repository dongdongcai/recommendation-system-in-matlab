test = {};
index = 1:100000;
randomi = index(randperm(length(index)));
for i = 1:10
    low = (i - 1) * 10000 + 1;
    high = i * 10000;
    set = randomi(low:high);
    test = [test; set];
end