classdef Plotter < handle
    properties
        time;
        index;

        data;
        handles;
    end

    methods
        function self = Plotter(plots,parameters)     
            self.time = NaN*ones(1,ceil(parameters.length/parameters.sample));
           
            names = fieldnames(plots,'-full');

            for k = 1:length(names)
                self.data = setfield(self.data,names{k},NaN*ones(1,ceil(parameters.length/parameters.sample)));
            end

            self.index = 1;

            %CREATE FIGURE
            figure(2);
            %CLEAR FIGURE
            clf;
            %TITLE FIGURE
            title(parameters.title);

            for k = 1:length(names)
                variable = plots.(names{k});

                if ~isfield(variable,"color") || variable.color == ""
                    warning("Variable: " + names{k} + " doesn't have color property. Assigning it black");
                    variable.color = "k";
                end

                if ~isfield(variable,"value")
                    error("Variable: " + names{k} + " needs a value property");
                end

                if ~isfield(variable,"index")
                    error("Variable: " + names{k} + " needs a index property");
                end
              
                %SUBPLOT
                subplot(parameters.plots(2),parameters.plots(1),variable.index);
                %HOLD ON
                hold on;

                self.handles = setfield(self.handles,names{k},plot(self.time,self.data.(names{k}),variable.color));

                if ~isfield(variable,"unit") || isempty(variable.unit) || variable.unit == ""
                    ylabel(strcat(names{k}));
                else
                    ylabel(strcat(names{k},'(',variable.unit,')'));
                end
            end
        end

        function self = update(self,plots,parameters)
            self.time(self.index) = parameters.time;

            names = fieldnames(plots,'-full');

            for k = 1:length(names)
                variable = plots.(names{k});

                if isfield(variable,"disabled") && variable.disabled == true
                    continue;
                end

                if ~isfield(variable,"color") || variable.color == ""
                    variable.color = "b";
                end

                if ~isfield(variable,"value")
                    error("Variable: " + names{k} + " needs a value property");
                end

                self.data.(names{k})(self.index) = variable.value;

                set(self.handles.(names{k}), 'Xdata',self.time,'Ydata',self.data.(names{k}));
            end

            self.index = self.index + 1;
        end
    end
end
