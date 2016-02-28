R = zeros(943, 1682);
for i=1:100000
    user = u(i, 1);
    movie = u(i, 2);
    rating = u(i, 3);
    R(user, movie) = rating;
end
for i=1:943
    for j = 1:1682
        if R(i, j) == 0
            R(i, j) = nan;
        end
    end
end