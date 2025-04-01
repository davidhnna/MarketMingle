function listings = searchItems(listings)
    if isempty(listings)
        fprintf("No listings available.\n");
        return;
    end

    searchItem = input("Enter item name (or press Enter to skip): ", 's');
    minSearchPrice = input("Enter minimum price (or press Enter to skip): ", 's');
    maxSearchPrice = input("Enter maximum price (or press Enter to skip): ", 's');
    searchCondition = input("Enter condition ('New', 'Good', 'Fair', 'Like New', 'Any' or press Enter to skip): ", 's');

    % Convert price inputs to numbers
    if isempty(minSearchPrice)
        minSearchPrice = -inf; % No lower limit
    else
        minSearchPrice = str2double(minSearchPrice);
    end

    if isempty(maxSearchPrice)
        maxSearchPrice = inf; % No upper limit
    else
        maxSearchPrice = str2double(maxSearchPrice);
    end

    % Filter listings based on search criteria
    fprintf("\n=== Search Results ===\n");
    found = false;

    for i = 1:size(listings, 1)
        listing = listings(i, :);
        itemName = listing{2};
        itemPrice = listing{3};
        itemCondition = listing{4};

        if (~isempty(searchItem) && ~contains(lower(itemName), lower(searchItem))) || ...
           (itemPrice < minSearchPrice || itemPrice > maxSearchPrice) || ...
           (~isempty(searchCondition) && ~strcmpi(searchCondition, 'Any') && ~strcmpi(itemCondition, searchCondition))
            continue;
        end

        fprintf("Seller: %s | Item: %s | Price: %.2f | Condition: %s | Location: %s\n", ...
                listing{1}, itemName, itemPrice, itemCondition, listing{5});
        found = true;
    end

    if ~found
        fprintf("No matching items found.\n");
    end
end
