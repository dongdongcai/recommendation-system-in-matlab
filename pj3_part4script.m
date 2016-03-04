opts = struct('iter',200);
thre = 0:0.004:1.5;
precision = zeros(1, length(thre));
recall = zeros(1, length(thre));
for i = 1:1
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    temp = test{i};
    tempR = R;
    for j = 1:10000
        %testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
        tempR(u(temp(j), 1), u(temp(j), 2)) = nan;
    end
    predict = pj3_part42(tempR,100,1,opts); % you can change k and lambda here
    %predict = A * Y;
    pointer = 1;
    for k = 1:length(thre)
        precisionpre = 0;
        precisionact = 0;
        recallact = 0;
        recallpre = 0;
        for j = 1:10000
            user = u(temp(j), 1);
            movie = u(temp(j), 2);
            if predict(user, movie) > thre(k)
                precisionpre = precisionpre + 1;
                if R(user, movie) > 3
                    precisionact = precisionact + 1;
                end
            end
            %if R(user, movie) > 3
            %    precisionpre = precisionpre + 1;
            %    if predict(user, movie) > thre(k)
            %        precisionact = precisionact + 1;
            %    end
            %end            
            %if R(user, movie) <= 3 && R(user, movie) > 0
            if R(user, movie) > 3
                recallact = recallact + 1;
                if predict(user, movie) > thre(k)
                    recallpre = recallpre + 1;
                end
            end
        end
        precision(pointer) = precision(pointer) + precisionact / precisionpre;
        recall(pointer) = recall(pointer) + recallpre / recallact;
        pointer = pointer + 1;
    end
end
precision = precision;
recall = recall;
plot(recall, precision);
xlabel('recall');
ylabel('precision');
title('ROC curve with different threshold');