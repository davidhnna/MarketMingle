function users = registerUser(users, name, email, location, priceRange, category, condition)
  
    if isempty(users)
        users = {};  
    end
    
    if ~isempty(users) && size(users, 2) >= 2
        emailExists = any(strcmp(users(:, 2), email));
    else
        emailExists = false;
    end
   
    if emailExists
        fprintf('Error: Email "%s" is already registered.\n', email);
    else
       
        preferences = struct('PriceRange', priceRange, ...
                             'Category', category, ...
                             'Condition', condition);

      
        if ~isempty(users) && size(users, 2) ~= 4
            error('Inconsistent structure: users must have exactly 4 columns.');
        end

      
        users = [users; {name, email, location, preferences}];

        
        saveDir = '../data';
        saveFile = fullfile(saveDir, 'users.mat');

      
        if ~exist(saveDir, 'dir')
            mkdir(saveDir);
        end

        
        save(saveFile, 'users');
        fprintf('Success! User "%s" has been registered.\n', name);
    end
end
