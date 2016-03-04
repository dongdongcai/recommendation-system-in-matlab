%size = size(R);
%predictedR = zeros(size(1), size(2));
%for i = 1:10
%    word=sprintf('fold %0.0d. \n ',i);
%    disp(word);
%    temp = test{i};
%    testpart = [];
%    for j = 1:10000
%        testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
%    end
%    predict = pj3_part4(R,100); % you can change k here
%    for j = 1:10000
%        user = u(temp(j), 1);
%        movie = u(temp(j), 2);
%        predictedR(user, movie) = predict(user, movie);
%    end
%end
total = 0;
hitpercentage = [];
falsepercentage = [];
for L = 1:20
    hitrate = 0;
    falserate = 0;
    for j = 1:size(1)
        prerow = predict(j,:);
        [presorted, presortedindex] = sort(prerow, 'descend');
        pretopL = presortedindex(1:L);
        preliketrue = 0;
        prelikefalse = 0;
        actlike = 0;
        dislike = 0;
        for k = 1:L
            if R(j, pretopL(k)) > 2
                actlike = actlike + 1;
                if predictedR(j, pretopL(k)) > 0.4
                    preliketrue = preliketrue + 1;
                end
            end     
            if R(j, pretopL(k)) <= 2
                dislike = dislike + 1;
                if predictedR(j, pretopL(k)) > 0.4
                    prelikefalse = prelikefalse + 1;
                end
            end
        end
        if preliketrue ~= 0 || actlike ~= 0
            hitrate = hitrate + preliketrue / actlike;
        end
        if prelikefalse~= 0 || dislike ~= 0
            falserate = falserate + prelikefalse / dislike;
        end
    end
    hitpercentage = [hitpercentage, hitrate / size(1)];
    falsepercentage = [falsepercentage, falserate / size(1)];
end
plot(falsepercentage, hitpercentage);
xlabel('falserate');
ylabel('hitrate');