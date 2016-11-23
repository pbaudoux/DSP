x = [yid, yni];
nttf = [256 1024 4096];
windows = [1 2 3];
for i=1:2
    figure
    for j=1:3
        for k=1:3
            subplot(3,3,(j-1)*3+k)
            plot(-1)
        end
    end
end
