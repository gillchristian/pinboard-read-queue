import styled from 'styled-components'

export default styled.a.attrs({
  rel: p => (p.external ? 'noreferer noopener' : ''),
  target: p => (p.external ? '_blank' : p.target),
})`

`
