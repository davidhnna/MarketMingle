function listings = createListing(listings, username, item, price)
    % Adds a new listing to the marketplace using a cell array
    % listings - current cell array of listings
    % username - seller's name (string)
    % item - item name (string)
    % price - item price (numeric)
    
    newListing = {username, item, price};  % Store as a cell
    listings = [listings; newListing];     % Append as a new row
    
    disp('Listing added successfully.');
end
