function searchItems(listings, keyword)
    % Searches for items in the marketplace
    % listings - struct array of listings
    % keyword - search term

    found = false;
    for i = 1:length(listings)
        if contains(listings(i).Item, keyword, 'IgnoreCase', true)
            fprintf('Seller: %s, Item: %s, Price: %.2f\n', listings(i).Username, listings(i).Item, listings(i).Price);
            found = true;
        end
    end
    
    if ~found
        disp('No matching listings found.');
    end
end
