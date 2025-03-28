function preferences = setpreferences()
% Prompt user for the price range
minPrice = input('Enter minimum price: $');
maxPrice = input('Enter maximum price: $');
% Check input price
while minPrice > maxPrice
  fprintf('Error: Minimum price cannot be greater than maximum price.\n');
  minPrice = input('Re-enter minimum price: $');
  maxPrice = input('Re-enter maximum price: $');
end
% Prompt user for preferences of preferred condition
preferredConditions = ["New", "Good", "Fair", "Like New", "Any"];
fprintf('Available conditions: %s\n', strjoin(preferredConditions, ', '));
condition = input('Enter preferred item condition: ', 's');
% Check input
while ~ismember(condition, preferredConditions)
  disp('Condition is invalid. Please choose a valid one.')
  condition = input('Please re-enter a valid preferred item condition: ', 's');
end
% Prompt user for preferred category
categories = ["Books", "Clothing", "Gadgets", "Electronics", "Furniture", "Other"];
fprintf('Available categories: %s\n', strjoin(categories, ', '));
category = input('Enter preferred category: ', 's');
% Check input
while ~ismember(category, categories)
  disp('Category is invalid, please select a valid category.')
  category = input('Please re-enter a valid category: ', 's');
end
% Store preferences in a struct
preferences = struct('minPrice', minPrice, ...
                   'maxPrice', maxPrice, ...
                   'condition', condition, ...
                   'category', category);
disp('Preferences saved');
end
