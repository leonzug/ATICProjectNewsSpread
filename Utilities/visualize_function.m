function [average_indegree] = visualize_function(A,X,nodenames,duration,nfigure,step_size,dynamic,plot_graph)
    G = digraph(A,nodenames);
    average_indegree = mean(indegree(G));
    %bins = conncomp(G);
    %figure(nfigure)
    delay = 0.00000001; % in [s]
    %colorMap = [linspace(0.8,0,256)',linspace(0.8,0,256)',linspace(0.8,0,256)' ];
    %colormap(colorMap);
    colormap jet
    if plot_graph
        if dynamic
            for i = 1:size(X,1)
                %hold on

                if mod(i,step_size)==0
                    figure(nfigure)
                    p=plot(G,'EdgeLabel',round(G.Edges.Weight,1), 'Marker', 'o', 'MarkerSize', 12,'NodeCData',X(i,:),'NodeColor', 'flat'); 
                    title("iterazione: "+ i)
                    colorbar;
                    caxis([-1 1]);
                    pause(delay);
                end
                %hold off
            end
        else
            figure(nfigure)
            p=plot(G,'EdgeLabel',round(G.Edges.Weight,1), 'Marker', 'o', 'MarkerSize', 12,'NodeCData',X(end,:),'NodeColor', 'flat'); 
            title("Solution at final step")
            colorbar;
            caxis([-1 1]);
        end
    end
end

