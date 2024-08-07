function Response(isSuccess, message, data)
  if not isSuccess then
    return {
      status = "error",
      message = message
    }
  end
  return {
    status = "success",
    data = data,
    message = message
  }
end
