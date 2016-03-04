load u.data;
build_matrix;
createtest;
opts1 = struct('dis', false);
opts2 = struct('dis', false);
[r, c] = size(R);
kpara = [10, 50, 100];
lambda = [0.01, 0.1, 1];
%--------------------------
%Part 1
%--------------------------
leastsquareerror1 = zeros(1, 3);

[A11,Y11,numIter11,tElapsed,finalResidual11] = wnmfrule(R, 10, opts1);
[A12,Y12,numIter12,tElapsed,finalResidual12] = wnmfrule(R, 50, opts1);
[A13,Y13,numIter13,tElapsed,finalResidual13] = wnmfrule(R, 100, opts1);

leastsquareerror1(1) = finalResidual11;
leastsquareerror1(2) = finalResidual12;
leastsquareerror1(3) = finalResidual13;

%--------------------------
%Part 2
%--------------------------

predictedR = cell(1,3);
minaberror2 = zeros(1, 3);
maxaberror2 = zeros(1, 3);
meanaberror2 = zeros(1, 3);
errork = zeros(3, 10);
for k = 1:3
    predictedR{1, k} = zeros(r, c);
    for i = 1:10
        tempR = R;
        word=sprintf('fold %0.0d. \n ',i);
        disp(word);
        temptest = test{i};
        testmatrix = zeros(r, c);
        for j = 1:10000
            tempR(u(temptest(j), 1), u(temptest(j), 2)) = nan;
            testmatrix(u(temptest(j), 1), u(temptest(j), 2)) = 1;
        end
        [tempA, tempY] = wnmfrule(tempR, kpara(k), opts2);
        temppredict = tempA * tempY;
        thiserror = sum(sum(testmatrix .* abs(temppredict - testR)));
        errork(k, i) = thiserror / 10000;
        predictedR{1, k} = predictedR{1, k} + testmatrix .* temppredict;
    end
    minaberror2(k) = min(errork(k, :));
    maxaberror2(k) = max(errork(k, :));
    meanaberror2(k) = mean(errork(k, :));
end

% --------------------------
% Part 3
% --------------------------

thre3 = 0:0.01:5.1;
precision3 = zeros(3, length(thre3));
recall3 = zeros(3, length(thre3));
for m = 1:3
    temppredict = predictedR{1, m};
    for i = 1:10
        temptest = test{i};
        for k = 1:length(thre3)
            precisionpre3 = 0;
            precisionact3 = 0;
            recallact3 = 0;
            recallpre3 = 0;
            for j = 1:10000
                user = u(temptest(j), 1);
                movie = u(temptest(j), 2);
                if predictedR{1, m}(user, movie) > thre3(k)
                    precisionpre3 = precisionpre3 + 1;
                    if R(user, movie) > 3
                        precisionact3 = precisionact3 + 1;
                    end
                end
                if R(user, movie) > 3
                    recallact3 = recallact3 + 1;
                    if predictedR{1, m}(user, movie) > thre3(k)
                        recallpre3 = recallpre3 + 1;
                    end
                end
            end
        precision3(m, k) = precision3(m, k) + precisionact3 / precisionpre3;
        recall3(m, k) = recall3(m, k) + recallpre3 / recallact3;
        end
    end
end
precision3 = precision3 / 10;
recall3 = recall3 / 10;
figure;
plot(recall3(1, :), precision3(1, :), 'r', recall3(2, :), precision3(2, :), 'g', recall3(3, :), precision3(3, :), 'b');
title('Precision versus Recall')
xlabel('Recall')
ylabel('Precision')
legend('k = 10', 'k = 50', 'k = 100')

figure;
plot(thre3(:), precision3(1, :), 'r', thre3(:), precision3(2, :), 'g', thre3(:), precision3(3, :), 'b')
str = sprintf('Precision versus Threshold');
title(str)
xlabel('Threshold')
ylabel('Precision')
legend('k = 10', 'k = 50', 'k = 100')

figure;
plot(thre3(:), recall3(1, :), 'r', thre3(:), recall3(2, :), 'g', thre3(:), recall3(3, :), 'b')
str = sprintf('Recall versus Threshold');
title(str)
xlabel('Threshold')
ylabel('Recall')
legend('k = 10', 'k = 50', 'k = 100')

% --------------------------
% Part 4
% --------------------------

leastsquareerror4 = zeros(1, 3);

[X41,numIter11,tElapsed,finalResidual41] = pj3_part4(R, 10, opts1);
[X42,numIter12,tElapsed,finalResidual42] = pj3_part4(R, 50, opts1);
[X43,numIter13,tElapsed,finalResidual43] = pj3_part4(R, 100, opts1);

leastsquareerror4(1) = finalResidual41;
leastsquareerror4(2) = finalResidual42;
leastsquareerror4(3) = finalResidual43;

predictedRlambda = cell(3,3); %row for lambda and col for k
for m = 1:3
    for n = 1:3
        predictedRlambda{m, n} = zeros(r, c);
        for i = 1:10
            tempR = R;
            word=sprintf('fold %0.0d. \n ',i);
            disp(word);
            temptest = test{i};
            testmatrix = zeros(r, c);
            for j = 1:10000
                tempR(u(temptest(j), 1), u(temptest(j), 2)) = nan;
                testmatrix(u(temptest(j), 1), u(temptest(j), 2)) = 1;
            end
            predictedRlambda{m, n} = predictedRlambda{m, n} + testmatrix .* pj3_part42(R, kpara(n), lambda(m), opts2);
        end
    end
end

thre4 = 0.8:0.0004:1;
precision4 = zeros(3, length(thre4), 3);
recall4 = zeros(3, length(thre4), 3);
for m = 1:3
    for n = 1:3
        temppredict = predictedRlambda{m, n};
        for i = 1:10
            temptest = test{i};
            for k = 1:length(thre4)
                precisionpre4 = 0;
                precisionact4 = 0;
                recallact4 = 0;
                recallpre4 = 0;
                for j = 1:10000
                    user = u(temptest(j), 1);
                    movie = u(temptest(j), 2);
                    if temppredict(user, movie) > thre4(k)
                        precisionpre4 = precisionpre4 + 1;
                        if R(user, movie) > 3
                        precisionact4 = precisionact4 + 1;
                        end
                    end
                    if R(user, movie) > 3
                        recallact4 = recallact4 + 1;
                        if temppredict(user, movie) > thre4(k)
                            recallpre4 = recallpre4 + 1;
                        end
                    end
                end
            precision4(n, k, m) = precision4(n, k, m) + precisionact4 / precisionpre4;
            recall4(n, k, m) = recall4(n, k, m) + recallpre4 / recallact4;
            end
        end
    end
end

precision4 = precision4 / 10;
recall4 = recall4 / 10;
for n = 1:3
    figure;
    plot(recall4(1, :, n), precision4(1, :, n), 'r', recall4(2, :, n), precision4(2, :, n), 'g', recall4(3, :, n), precision4(3, :, n), 'b')
    str = sprintf('Precision versus Recall (Regularized wnmf) for lambda = %d', lambda(n));
    title(str)
    xlabel('Recall')
    ylabel('Precision')
    legend('k = 10', 'k = 50', 'k = 100')

    figure;
    plot(thre4(:), precision4(1, :, n), 'r', thre4(:), precision4(2, :, n), 'g', thre4(:), precision4(3, :, n), 'b')
    str = sprintf('Precision versus Threshold (Regularized wnmf) for lambda = %d', lambda(n));
    title(str)
    xlabel('Threshold')
    ylabel('Precision')
    legend('k = 10', 'k = 50', 'k = 100')

    figure;
    plot(thre4(:), recall4(1, :, n), 'r', thre4(:), recall4(2, :, n), 'g', thre4(:), recall4(3, :, n), 'b')
    str = sprintf('Recall versus Threshold (Regularized wnmf) for lambda = %d', lambda(n));
    title(str)
    xlabel('Threshold')
    ylabel('Recall')
    legend('k = 10', 'k = 50', 'k = 100')
end

% --------------------------
% Part 5
% --------------------------

sortedRpred = cell(3, 3, r);
for m = 1:3
    for n = 1:3
        for j = 1:r
            prerow = predictedRlambda{m, n}(j,:);
            [presorted, presortedindex] = sort(prerow, 'descend');
            sortedRpred{m, n, j} = presortedindex;
        end
    end
end

averprecision5 = zeros(3, 3);
for m = 1:3
    for n = 1:3
        percentage5 = 0;
        for j = 1:r
            hit = 0;
            pretopfive = sortedRpred{m, n, j}(1:5);
            for k = 1:5
                if R(j, pretopfive(k)) > 2
                    hit = hit + 1;
                end
            end
            percentage5 = percentage5 + hit / 5;
        end
        averprecision5(m, n) = percentage5 / r;
    end
end

hitpercentage5 = zeros(3, 20, 3);
falsepercentage5 = zeros(3, 20, 3);
for m = 1:3
    for n = 1:3
        for L = 1:20
            hitrate = 0;
            falserate = 0;
            for j = 1:r
                pretopL = sortedRpred{m, n, j}(1:L);
                preliketrue = 0;
                prelikefalse = 0;
                actlike = 0;
                dislike = 0;
                liketotal = sum(R(j, :) > 3);
                disliketotal = sum(R(j,:) <= 3);
                for k = 1:L                   
                    if R(j, pretopL(k)) > 3
                        actlike = actlike + 1;
                        %if predictedRlambda{m,n}(j, pretopL(k)) > 0.985
                            %preliketrue = preliketrue + 1;
                        %end
                    end     
                    if R(j, pretopL(k)) <= 3 && predictedRlambda{m,n}(j, pretopL(k)) > 0.985
                        dislike = dislike + 1;
                        %if predictedRlambda{m,n}(j, pretopL(k)) > 0.985
                            %prelikefalse = prelikefalse + 1;
                        %end
                    end
                end
                %if preliketrue ~= 0 || actlike ~= 0
                if liketotal ~= 0
                    %hitrate = hitrate + preliketrue / actlike;
                    hitrate = hitrate + actlike / liketotal;
                else
                    hitrate = hitrate + 1;
                end
                %if prelikefalse~= 0 || dislike ~= 0
                if disliketotal ~= 0
                    %falserate = falserate + prelikefalse / dislike;
                    falserate = falserate + dislike / disliketotal;
                end
            end
            hitpercentage5(n, L, m) = hitrate / r;
            falsepercentage5(n, L, m) = falserate / r;
        end
    end
end

for n = 1:3
    figure;
    plot(falsepercentage5(1, :, n), hitpercentage5(1, :, n), 'r', falsepercentage5(2, :, n), hitpercentage5(2, :, n), 'g', falsepercentage5(3, :, n), hitpercentage5(3, :, n), 'b')
    str = sprintf('Hit rate versus False alarm rate for lambda = %d', lambda(n));
    title(str)
    xlabel('False alarm rate')
    ylabel('Hit rate')
    legend('k = 10', 'k = 50', 'k = 100')
end