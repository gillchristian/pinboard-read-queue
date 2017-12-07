const storage = (key, value) => {
  if (typeof value === 'undefined') {
    return JSON.parse(global.localStorage.getItem(key))
  }

  return global.localStorage.setItem(key, JSON.stringify(value))
}

export default storage
