function listings = createListing(listings, username, item, price, condition, location)

   if isempty(username) || isempty(item) || isempty(location) || ~isnumeric(price) || price <= 0
       disp('Error: All fields must be filled correctly, and price must be a positive number.');
       return;
   end

   newListing = {username, item, price, condition, location};
   listings = [listings; newListing];  

   saveDir = '../data';
   if ~exist(saveDir, 'dir')
       mkdir(saveDir);  
   end
   saveFile = fullfile(saveDir, 'listings.mat');
 
   try
       save(saveFile, 'listings');
     
       fprintf('Listing added successfully:\n');
       fprintf('Seller: %s | Item: %s | Price: $%.2f | Condition: %s | Location: %s\n', ...
               username, item, price, condition, location);
   catch
       disp('Error: Unable to save listing data.');
   end
end
