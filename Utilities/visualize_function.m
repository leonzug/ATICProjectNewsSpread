function visualize_function(A,X,duration,nfigure)
    G = digraph(A);
    %figure(nfigure)
    delay = 0.00000001; % in [s]
    time_disc = duration/size(X,1);
    colorMap = [linspace(0.8,0,256)',linspace(0.8,0,256)',linspace(0.8,0,256)' ];
    colormap(colorMap);
    colormap jet
    for i = 1:size(X,1)
        %hold on
        figure(nfigure)
        p=plot(G,'EdgeLabel',G.Edges.Weight, 'Marker', 'o', 'MarkerSize', 20,'NodeCData',X(i,:),'NodeColor', 'flat'); 
        colorbar;
        caxis([-1 1]);
        title("at time: "+ i*time_disc)
        pause(delay);
        %hold off
    end
end

