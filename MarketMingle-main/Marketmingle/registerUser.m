% function for registering users
function users = registerUser(users, name, email, location, priceRange, category, condition)
  
    % Ensuring that users is always a cell array
    if isempty(users)
        users = {};  
    end
    
    % Check if email the email already exisits  to avoid duplicates
    if ~isempty(users) && size(users, 2) >= 2
        emailExists = any(strcmp(users(:, 2), email));
    else
        emailExists = false;
    end
    % error handling message if the user is already registered
    if emailExists
        fprintf('Error: Email "%s" is already registered.\n', email);
    else
        % Create a structure for user prefrences instead of making another cell array 
        preferences = struct('PriceRange', priceRange, ...
                             'Category', category, ...
                             'Condition', condition);

        % Ensure consistent structure before appending
        if ~isempty(users) && size(users, 2) ~= 4
            error('Inconsistent structure: users must have exactly 4 columns.');
        end

        % Append the new registered user
        users = [users; {name, email, location, preferences}];

        % Defining the save directory and file
        saveDir = '../data';
        saveFile = fullfile(saveDir, 'users.mat');

        % Create directory if it doesn't exist
        if ~exist(saveDir, 'dir')
            mkdir(saveDir);
        end

        % Save the updated users array
        save(saveFile, 'users');
        fprintf('Success! User "%s" has been registered.\n', name);
    end
end
