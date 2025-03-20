
function users = registerUser(users, name, email, location, priceRange, category, condition)
    % REGISTERUSER - Adds a new user to the users cell array.
    % Prevents duplicate emails and saves data to users.mat.

    % Check if email already exists
    emailExists = false;
    for i = 1:size(users, 1)
        if strcmp(users{i, 2}, email)
            fprintf('Error: Email "%s" is already registered.\n', email);
            emailExists = true;
            break;
        end
    end

    % If no duplicate found, register the user
    if ~emailExists
        % Create preferences structure
        preferences = struct('PriceRange', priceRange, ...
                             'Category', category, ...
                             'Condition', condition);

        % Add the new user to the cell array
        newUser = {name, email, location, preferences};
        users = [users; newUser];

        % Save the updated users array
        save('../data/users.mat', 'users');

        fprintf('Success! User "%s" has been registered.\n', name);
    end
end
