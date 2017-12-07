import { curry2 } from 'sanctuary'

export default curry2((i, xs) => [...xs.slice(0, i), ...xs.slice(i + 1)])
