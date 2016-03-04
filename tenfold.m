aberror = zeros(1, 10);
testR = R;
W=isnan(testR);
testR(W)=0;
opts = struct('iter',200);
for i = 1:10
    tempR = R;
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    temp = test{i};
    testpart = [];
    testmatrix = zeros(943, 1682);
    for j = 1:10000
        %testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
        tempR(u(temp(j), 1), u(temp(j), 2)) = nan;
        %tempR(u(j, 1), u(j, 2)) = nan;
        testmatrix(u(temp(j), 1), u(temp(j), 2)) = 1;
    end
    %thiserror = factofor10fold(R,100,testpart); %you can change k here
    [A, Y] = newwnmfrule(tempR, 10, opts);
    thiserror = sum(sum(testmatrix .* abs(A * Y - testR)));
    error(i) = thiserror / 10000;
end
averaberror = sum(error) / 10;