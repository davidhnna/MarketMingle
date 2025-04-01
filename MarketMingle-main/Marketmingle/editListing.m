function listings = editListing(listings)
    if isempty(listings)
        fprintf("No listings available to edit.\n");
        return;
    end

    username = input("Enter your username: ", 's');
    itemToEdit = input("Enter the item name you want to edit: ", 's');

    % Find the listing index
    listingIndex = -1;
    for i = 1:size(listings, 1)
        if strcmp(listings{i, 1}, username) && strcmpi(listings{i, 2}, itemToEdit)
            listingIndex = i;
            break;
        end
    end

    if listingIndex == -1
        fprintf("No matching listing found for the given username and item.\n");
        return;
    end

    % Display current details
    fprintf("\nCurrent Listing Details:\n");
    fprintf("Seller: %s | Item: %s | Price: %.2f | Condition: %s | Location: %s\n", ...
            listings{listingIndex, 1}, listings{listingIndex, 2}, ...
            listings{listingIndex, 3}, listings{listingIndex, 4}, listings{listingIndex, 5});

    % Ask for new values (or keep existing ones)
    newItem = input("Enter new item name (or press Enter to keep the same): ", 's');
    if isempty(newItem)
        newItem = listings{listingIndex, 2};
    end

    newPrice = input("Enter new price (or press Enter to keep the same): ", 's');
    if isempty(newPrice)
        newPrice = listings{listingIndex, 3};
    else
        newPrice = str2double(newPrice);
        if isnan(newPrice) || newPrice <= 0
            fprintf("Invalid price. Keeping previous value.\n");
            newPrice = listings{listingIndex, 3};
        end
    end

    newCondition = input("Enter new condition ('New', 'Good', 'Fair', 'Like New', 'Any') (or press Enter to keep the same): ", 's');
    if isempty(newCondition)
        newCondition = listings{listingIndex, 4};
    end

    newLocation = input("Enter new location (or press Enter to keep the same): ", 's');
    if isempty(newLocation)
        newLocation = listings{listingIndex, 5};
    end

    % Update the listing
    listings{listingIndex, 2} = newItem;
    listings{listingIndex, 3} = newPrice;
    listings{listingIndex, 4} = newCondition;
    listings{listingIndex, 5} = newLocation;

    fprintf("Listing updated successfully!\n");

    % Ensure the data directory exists
    if ~exist('../data', 'dir')
        mkdir('../data');
    end

    % Save updated listings
    save('../data/listings.mat', 'listings');
end
