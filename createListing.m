
function listings = createListing(listings, username, item, price)
    % Adds a new listing to the marketplace
    % listings - current struct array of listings
    % username - seller's name
    % item - item name
    % price - item price

    newListing = struct('Username', username, 'Item', item, 'Price', price);
    listings = [listings, newListing];
    disp('Listing added successfully.');
end
