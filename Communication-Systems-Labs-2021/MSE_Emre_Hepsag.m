function mse = MSE_Emre_Hepsag(original,modified)
    squared = (original-modified).^2;
    mse = sum(sum(squared),2)/numel(original);
end