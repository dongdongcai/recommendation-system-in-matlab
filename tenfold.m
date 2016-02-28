error = [];
for i = 1:1
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    tempW = W;
    temp = test{i};
    testpart = [];
    for j = 1:10000
        testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
    end
    error = [error, factofor10fold(R,100,testpart)];
end
aver = sum(error) / 10;