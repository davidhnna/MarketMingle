function listings = createListing(listings, username, item, price, condition, location)
   % CREATELISTING - Adds a new listing to the marketplace.
   % listings - current cell array of listings
   % username - seller's name (string)
   % item - item name (string)
   % price - item price (numeric, positive)
   % condition - item condition (string, e.g., 'New', 'Like New', 'Used')
   % location - item location (string)
  
   % Validate inputs
   if isempty(username) || isempty(item) || isempty(location) || ~isnumeric(price) || price <= 0
       disp('Error: All fields must be filled correctly, and price must be a positive number.');
       return;
   end
   % Create the new listing
   newListing = {username, item, price, condition, location};
   listings = [listings; newListing];  % Append new row
   % Define save directory and file
   saveDir = '../data';
   if ~exist(saveDir, 'dir')
       mkdir(saveDir);  % Create the directory if it does not exist
   end
   saveFile = fullfile(saveDir, 'listings.mat');
   % Save the updated listings array
   try
       save(saveFile, 'listings');
       % Display confirmation
       fprintf('Listing added successfully:\n');
       fprintf('Seller: %s | Item: %s | Price: $%.2f | Condition: %s | Location: %s\n', ...
               username, item, price, condition, location);
   catch
       disp('Error: Unable to save listing data.');
   end
end
