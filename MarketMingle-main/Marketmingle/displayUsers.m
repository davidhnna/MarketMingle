% function to display the registered users 
function displayUsers(users)
   % handling errors by messages if there are no registered users 
    if isempty(users)
        fprintf("No users registered yet.\n");
    else
      % print users if they are reigstered 
        fprintf("\n=== Registered Users ===\n");
        for i = 1:size(users, 1)
            fprintf("Name: %s, Username: %s, Location: %s\n", ...
                    users{i, 1}, users{i, 2}, users{i, 3});
        end
    end
end
