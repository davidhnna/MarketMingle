function displayUsers(users)
    if isempty(users)
        fprintf("No users registered yet.\n");
    else
        fprintf("\n=== Registered Users ===\n");
        for i = 1:size(users, 1)
            fprintf("Name: %s, Username: %s, Location: %s\n", ...
                    users{i, 1}, users{i, 2}, users{i, 3});
        end
    end
end
