function searchItems(listings, keyword, minPrice, maxPrice, location, condition)
  foundListings = {}; % Array to store matching results
  % Linear search with multiple conditions
  for i = 1:size(listings, 1)
      itemName = listings{i, 2};
      itemPrice = listings{i, 3};
      itemLocation = listings{i, 5};
      itemCondition = listings{i, 4};
      % Check keyword, price range, location, and condition
      if contains(itemName, keyword, 'IgnoreCase', true) && ...
         itemPrice >= minPrice && itemPrice <= maxPrice && ...
         (isempty(location) || strcmpi(itemLocation, location)) && ...
         (isempty(condition) || strcmpi(itemCondition, condition))
          foundListings = [foundListings; listings(i, :)];
      end
  end
  % Display Results
  if isempty(foundListings)
      disp('No matching listings found.');
  else
      fprintf('\n%-15s %-20s %-10s %-12s %-15s\n', ...
          'Seller', 'Item', 'Price', 'Condition', 'Location');
      fprintf(repmat('-', 1, 70)); % Divider
      fprintf('\n');
      % Display sorted results by price (optional feature)
      [~, idx] = sort(cell2mat(foundListings(:, 3)));
      sortedListings = foundListings(idx, :);
      % Show matching listings
      for i = 1:size(sortedListings, 1)
          fprintf('%-15s %-20s $%-9.2f %-12s %-15s\n', ...
              sortedListings{i, 1}, sortedListings{i, 2}, ...
              sortedListings{i, 3}, sortedListings{i, 4}, sortedListings{i, 5});
      end
  end
end
