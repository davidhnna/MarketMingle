function listings = simulateTransaction(listings, itemName, buyerUsername, users)
    itemFound = false;
    buyerFound = false;
    for i = 1:size(listings, 1)
        if strcmpi(listings{i, 2}, itemName)  % Match item name
            sellerUsername = listings{i, 1};  % Get seller username

            % Find buyer in users list
            for j = 1:size(users, 1)
                if strcmp(users{j, 2}, buyerUsername)  % Match username
                    buyerFound = true;
                    buyerIndex = j;
                    break;
                end
            end

            if ~buyerFound
                fprintf('Error: Buyer "%s" is not registered.\n', buyerUsername);
                return;
            end
            if size(users, 2) < 5 || isempty(users{buyerIndex, 5})
                users{buyerIndex, 5} = {};  % Initialize inventory if empty
            end
            users{buyerIndex, 5} = [users{buyerIndex, 5}, itemName];
            listings(i, :) = [];

            if ~exist('../data', 'dir')
                mkdir('../data');
            end
            save('../data/listings.mat', 'listings');
            save('../data/users.mat', 'users');

            fprintf('Success! "%s" has been purchased by %s from %s.\n', ...
                    itemName, buyerUsername, sellerUsername);
            itemFound = true;
            break;
        end
    end

    if ~itemFound
        fprintf('Error: "%s" is not available for purchase.\n', itemName);
    end
end
