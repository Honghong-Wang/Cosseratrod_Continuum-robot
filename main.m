% This is the entry point of this code repository.
% 
% The 5 scripts "mainX" called below correspond to the simulation
% procedures used for the 5 different scenarios of the corresponding paper
% available at: https://hal.science/hal-03935561/ .
%

function write_scenario_results(fid, scenario_name, position_error_median_mm, position_error_95CI_mm, orientation_error_median_deg, orientation_error_95CI_deg)
    fprintf(fid, '\nScenario %s\n----------\n', scenario_name);
    fprintf(fid, 'position [mm]:\n');
    fprintf(fid, '   - median:     %.2e\n', position_error_median_mm);
    fprintf(fid, '   - low 95 CI:  %.2e\n', position_error_95CI_mm(1));
    fprintf(fid, '   - high 95 CI: %.2e\n', position_error_95CI_mm(2));
    fprintf(fid, 'orientation [deg]:\n');
    fprintf(fid, '   - median:     %.2e\n', orientation_error_median_deg);
    fprintf(fid, '   - low 95 CI:  %.2e\n', orientation_error_95CI_deg(1));
    fprintf(fid, '   - high 95 CI: %.2e\n\n', orientation_error_95CI_deg(2));
end

fid = fopen('results_output.txt', 'w');

scenarios = {'A', 'B', 'C', 'D', 'E'};

for i = 1:length(scenarios)
    scenario = scenarios{i};
    try
        feval(['main', scenario]); % Call the main function for the current scenario
        write_scenario_results(fid, scenario, position_error_median_mm, position_error_95CI_mm, orientation_error_median_deg, orientation_error_95CI_deg);
    catch ME
        fprintf(fid, '\nScenario %s encountered an error: %s\n', scenario, ME.message);
    end
end

fclose(fid);

