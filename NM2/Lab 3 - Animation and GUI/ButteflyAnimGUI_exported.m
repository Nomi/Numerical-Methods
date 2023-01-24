classdef ButteflyAnimGUI_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        FlapWingsCheckBox              matlab.ui.control.CheckBox
        ChangecoloreveryframeCheckBox  matlab.ui.control.CheckBox
        ANIMATEButton                  matlab.ui.control.Button
        ColorChangesEditField          matlab.ui.control.NumericEditField
        ColorChangesEditFieldLabel     matlab.ui.control.Label
        TotalRotationEditField         matlab.ui.control.NumericEditField
        TotalRotationEditFieldLabel    matlab.ui.control.Label
        RunTimeapproxEditField         matlab.ui.control.NumericEditField
        RunTimeapproxEditFieldLabel    matlab.ui.control.Label
        FrameRateEditField             matlab.ui.control.NumericEditField
        FrameRateEditFieldLabel        matlab.ui.control.Label
        MovementSpeedScaleSlider       matlab.ui.control.Slider
        MovementSpeedScaleLabel        matlab.ui.control.Label
        ButterflySizeDropDown          matlab.ui.control.DropDown
        ButterflySizeDropDownLabel     matlab.ui.control.Label
        FlapDurationframesEditFieldLabel  matlab.ui.control.Label
        FlapDurationframesEditField    matlab.ui.control.NumericEditField
        RightPanel                     matlab.ui.container.Panel
        UIAxes                         matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    
    properties (Access = public)
        drawButtonPresses=0; % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ANIMATEButton
        function ANIMATEButtonPushed(app, event)
            cla(app.UIAxes); %clears the figure
            %app.drawButtonPresses=app.drawButtonPresses+1; %counts the draw presses, haven't used it for anything yet.
            try
                %calls the function.
                butterflyAnimFn( ...
                    app.UIAxes, ...
                    app.FrameRateEditField.Value, ...
                    app.RunTimeapproxEditField.Value, ...
                    app.MovementSpeedScaleSlider.Value, ...
                    app.FlapWingsCheckBox.Value, ...
                    app.FlapDurationframesEditField.Value, ...
                    app.ColorChangesEditField.Value, ...
                    app.TotalRotationEditField.Value);
            catch %this catches the error thrown when an animation is closed midway (either by closing the app or pressing the draw button again.)
                clear;  %clears workspace memory for the current function, just in case there's any memory leak due to the error.
            end
        end

        % Value changed function: ChangecoloreveryframeCheckBox
        function ChangecoloreveryframeCheckBoxValueChanged(app, event)
            value = app.ChangecoloreveryframeCheckBox.Value;
            if(value)
                app.ColorChangesEditField.Editable=false;
                app.ColorChangesEditField.Value=-1;
                %app.ColorChangesEditField.Visible=false;
            else
                app.ColorChangesEditField.Value=200;
                app.ColorChangesEditField.Editable=true;
            end
        end

        % Value changed function: FlapWingsCheckBox
        function FlapWingsCheckBoxValueChanged(app, event)
            value = app.FlapWingsCheckBox.Value;
            if(~value)
                app.ChangecoloreveryframeCheckBox.Value=true;
                app.ChangecoloreveryframeCheckBox.ValueChangedFcn(app,event);
                app.ChangecoloreveryframeCheckBox.Enable=false;
                app.FlapDurationframesEditField.Enable=false;
            else
                app.ChangecoloreveryframeCheckBox.Value=false;
                app.ChangecoloreveryframeCheckBox.ValueChangedFcn(app,event);
                app.ChangecoloreveryframeCheckBox.Enable=true;
                app.FlapDurationframesEditField.Enable=true;
            end
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {247, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 795 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {247, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.ForegroundColor = [0 0.4471 0.7412];
            app.LeftPanel.TitlePosition = 'centertop';
            app.LeftPanel.Title = 'Parameters';
            app.LeftPanel.BackgroundColor = [0.9255 0.9804 0.8627];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;
            app.LeftPanel.FontWeight = 'bold';

            % Create FlapWingsCheckBox
            app.FlapWingsCheckBox = uicheckbox(app.LeftPanel);
            app.FlapWingsCheckBox.ValueChangedFcn = createCallbackFcn(app, @FlapWingsCheckBoxValueChanged, true);
            app.FlapWingsCheckBox.Text = 'Flap Wings';
            app.FlapWingsCheckBox.Position = [6 294 234 22];
            app.FlapWingsCheckBox.Value = true;

            % Create ChangecoloreveryframeCheckBox
            app.ChangecoloreveryframeCheckBox = uicheckbox(app.LeftPanel);
            app.ChangecoloreveryframeCheckBox.ValueChangedFcn = createCallbackFcn(app, @ChangecoloreveryframeCheckBoxValueChanged, true);
            app.ChangecoloreveryframeCheckBox.Text = 'Change color every frame.';
            app.ChangecoloreveryframeCheckBox.Position = [34 273 206 22];

            % Create ANIMATEButton
            app.ANIMATEButton = uibutton(app.LeftPanel, 'push');
            app.ANIMATEButton.ButtonPushedFcn = createCallbackFcn(app, @ANIMATEButtonPushed, true);
            app.ANIMATEButton.BusyAction = 'cancel';
            app.ANIMATEButton.BackgroundColor = [0.3098 0.4 0.4118];
            app.ANIMATEButton.FontName = 'Segoe UI';
            app.ANIMATEButton.FontSize = 20;
            app.ANIMATEButton.FontWeight = 'bold';
            app.ANIMATEButton.FontColor = [1 1 1];
            app.ANIMATEButton.Position = [34 21 170 86];
            app.ANIMATEButton.Text = 'ANIMATE';

            % Create ColorChangesEditField
            app.ColorChangesEditField = uieditfield(app.LeftPanel, 'numeric');
            app.ColorChangesEditField.Limits = [-1 500];
            app.ColorChangesEditField.HorizontalAlignment = 'center';
            app.ColorChangesEditField.Position = [159 252 82 22];
            app.ColorChangesEditField.Value = 200;

            % Create ColorChangesEditFieldLabel
            app.ColorChangesEditFieldLabel = uilabel(app.LeftPanel);
            app.ColorChangesEditFieldLabel.Position = [34 252 114 22];
            app.ColorChangesEditFieldLabel.Text = 'Color Changes';

            % Create TotalRotationEditField
            app.TotalRotationEditField = uieditfield(app.LeftPanel, 'numeric');
            app.TotalRotationEditField.ValueDisplayFormat = '%.4f Radians';
            app.TotalRotationEditField.HorizontalAlignment = 'center';
            app.TotalRotationEditField.Position = [118 390 121 22];
            app.TotalRotationEditField.Value = 10.471975511966;

            % Create TotalRotationEditFieldLabel
            app.TotalRotationEditFieldLabel = uilabel(app.LeftPanel);
            app.TotalRotationEditFieldLabel.Position = [4 390 114 22];
            app.TotalRotationEditFieldLabel.Text = 'Total Rotation';

            % Create RunTimeapproxEditField
            app.RunTimeapproxEditField = uieditfield(app.LeftPanel, 'numeric');
            app.RunTimeapproxEditField.Limits = [1 3600];
            app.RunTimeapproxEditField.ValueDisplayFormat = '%11.4g Seconds';
            app.RunTimeapproxEditField.HorizontalAlignment = 'center';
            app.RunTimeapproxEditField.Position = [118 324 121 22];
            app.RunTimeapproxEditField.Value = 10;

            % Create RunTimeapproxEditFieldLabel
            app.RunTimeapproxEditFieldLabel = uilabel(app.LeftPanel);
            app.RunTimeapproxEditFieldLabel.Position = [5 324 113 22];
            app.RunTimeapproxEditFieldLabel.Text = 'Run Time (approx.)';

            % Create FrameRateEditField
            app.FrameRateEditField = uieditfield(app.LeftPanel, 'numeric');
            app.FrameRateEditField.Limits = [1 Inf];
            app.FrameRateEditField.ValueDisplayFormat = '%11.4g FPS';
            app.FrameRateEditField.HorizontalAlignment = 'center';
            app.FrameRateEditField.Position = [119 357 121 22];
            app.FrameRateEditField.Value = 60;

            % Create FrameRateEditFieldLabel
            app.FrameRateEditFieldLabel = uilabel(app.LeftPanel);
            app.FrameRateEditFieldLabel.Position = [6 357 113 22];
            app.FrameRateEditFieldLabel.Text = 'Frame Rate';

            % Create MovementSpeedScaleSlider
            app.MovementSpeedScaleSlider = uislider(app.LeftPanel);
            app.MovementSpeedScaleSlider.Limits = [0 10];
            app.MovementSpeedScaleSlider.Position = [10 178 218 3];
            app.MovementSpeedScaleSlider.Value = 0.5;

            % Create MovementSpeedScaleLabel
            app.MovementSpeedScaleLabel = uilabel(app.LeftPanel);
            app.MovementSpeedScaleLabel.VerticalAlignment = 'top';
            app.MovementSpeedScaleLabel.Position = [7 190 136 22];
            app.MovementSpeedScaleLabel.Text = 'Movement Speed Scale:';

            % Create ButterflySizeDropDown
            app.ButterflySizeDropDown = uidropdown(app.LeftPanel);
            app.ButterflySizeDropDown.Items = {'Small', 'Medium', 'Large'};
            app.ButterflySizeDropDown.Enable = 'off';
            app.ButterflySizeDropDown.Position = [120 420 121 22];
            app.ButterflySizeDropDown.Value = 'Small';

            % Create ButterflySizeDropDownLabel
            app.ButterflySizeDropDownLabel = uilabel(app.LeftPanel);
            app.ButterflySizeDropDownLabel.Enable = 'off';
            app.ButterflySizeDropDownLabel.Position = [6 420 113 22];
            app.ButterflySizeDropDownLabel.Text = 'Butterfly Size';

            % Create FlapDurationframesEditFieldLabel
            app.FlapDurationframesEditFieldLabel = uilabel(app.LeftPanel);
            app.FlapDurationframesEditFieldLabel.Position = [34 229 126 22];
            app.FlapDurationframesEditFieldLabel.Text = 'Flap Duration (frames)';

            % Create FlapDurationframesEditField
            app.FlapDurationframesEditField = uieditfield(app.LeftPanel, 'numeric');
            app.FlapDurationframesEditField.Limits = [-1 500];
            app.FlapDurationframesEditField.HorizontalAlignment = 'center';
            app.FlapDurationframesEditField.Position = [159 229 81 22];
            app.FlapDurationframesEditField.Value = 120;

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.9294 0.9882 0.9686];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, 'Butterfly Animation')
            zlabel(app.UIAxes, {''; ''})
            app.UIAxes.Toolbar.Visible = 'off';
            app.UIAxes.PlotBoxAspectRatio = [1 1.12910284463895 1];
            app.UIAxes.XLim = [-10 10];
            app.UIAxes.YLim = [-10 10];
            app.UIAxes.XColor = [1 1 1];
            app.UIAxes.XTick = [-10 -5 0 5 10];
            app.UIAxes.XTickLabel = '';
            app.UIAxes.YColor = [1 1 1];
            app.UIAxes.YTick = [-10 -5 0 5 10];
            app.UIAxes.YTickLabel = '';
            app.UIAxes.BusyAction = 'cancel';
            app.UIAxes.HitTest = 'off';
            app.UIAxes.Position = [1 6 541 468];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ButteflyAnimGUI_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end