function visualize_function(A,X,nodenames,duration,nfigure,step_size)
    G = digraph(A,nodenames);
    bins = conncomp(G);
    %figure(nfigure)
    delay = 0.00000001; % in [s]
    colorMap = [linspace(0.8,0,256)',linspace(0.8,0,256)',linspace(0.8,0,256)' ];
    colormap(colorMap);
    colormap jet
    for i = 1:size(X,1)
        %hold on

        if mod(i,step_size)==0
            figure(nfigure)
            p=plot(G,'EdgeLabel',round(G.Edges.Weight,3), 'Marker', 'o', 'MarkerSize', 12,'NodeCData',X(i,:),'NodeColor', 'flat'); 
            title("iterazione: "+ i)
            colorbar;
            caxis([-1 1]);
            pause(delay);
        end
        %hold off
    end
end

