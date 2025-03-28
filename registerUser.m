function users = registerUser(users, name, email, location, priceRange, category, condition)
   % REGISTERUSER - Adds a new user to the users cell array.
   % Prevents duplicate emails and saves data to users.mat.
   % Ensure users is initialized properly
   if isempty(users)
       users = {};
   end
   % Check if email already exists
   emailExists = false;
   if ~isempty(users) % Only check for duplicate emails if users is not empty
       emailExists = any(cellfun(@(x) strcmp(x, email), users(:, 2)));
   end
   if emailExists
       fprintf('Error: Email "%s" is already registered.\n', email);
   else
       % Create preferences structure
       preferences = struct('PriceRange', priceRange, ...
                            'Category', category, ...
                            'Condition', condition);
      
       % Add the new user to the cell array
       newUser = {name, email, location, preferences};
       users = [users; newUser];
       % Define save directory and file
       saveDir = '../data';
       saveFile = fullfile(saveDir, 'users.mat');
       % Check if directory exists; if not, create it
       if ~exist(saveDir, 'dir')
           mkdir(saveDir);
       end
       % Save the updated users array
       save(saveFile, 'users');
       fprintf('Success! User "%s" has been registered.\n', name);
   end
end
