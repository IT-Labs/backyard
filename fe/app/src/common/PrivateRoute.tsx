import React from 'react'
import { useKeycloak } from '@react-keycloak/web'
import { Route, RouteProps } from 'react-router-dom'
interface PrivateRouteProps extends RouteProps {
  // tslint:disable-next-line:no-any
  component?: any;
  // tslint:disable-next-line:no-any
  children?: any;
}
const PrivateRoute = (props: PrivateRouteProps) => {
  const { component: Component,  ...rest } = props;
  const { keycloak } = useKeycloak()
  return (
    <Route
      {...rest}
      render={props => (
        keycloak?.authenticated ? <Component {...props} /> : keycloak.login()
      )}
    />
  )
}

export default PrivateRoute