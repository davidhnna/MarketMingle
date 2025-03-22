function searchItems(listings, keyword)
    % Searches for items in the marketplace using a cell array and linear search
    % listings - cell array of listings, where each row is {Username, Item, Price}
    % keyword - search term (string)
    
    found = false;
    
    % Linear Search Algorithm for item lookup
    for i = 1:size(listings, 1)
        if contains(listings{i, 2}, keyword, 'IgnoreCase', true) % Search by Item name
            fprintf('Seller: %s, Item: %s, Price: %.2f\n', listings{i, 1}, listings{i, 2}, listings{i, 3});
            found = true;
        end
    end
    
    if ~found
        disp('No matching listings found.');
    end
end
