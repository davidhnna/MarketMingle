function listings = simulateTransaction(listings, itemName, buyerEmail)
    % Simulate purchasing an item
    itemFound = false;

    % Loop through listings to find the item
    for i = 1:size(listings, 1)
        if strcmp(listings{i, 1}, itemName) && strcmp(listings{i, 7}, 'Available')
            % Mark item as 'Sold'
            listings{i, 7} = 'Sold';

            % Display success message
            fprintf('Success! "%s" has been purchased by %s.\n', itemName, buyerEmail);

            % Save the updated listings
            save('../data/listings.mat', 'listings');

            itemFound = true;
            break;
        end
    end

    % If item was not found or already sold
    if ~itemFound
        fprintf('Error: "%s" is not available for purchase.\n', itemName);
    end
end