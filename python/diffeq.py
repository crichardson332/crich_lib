############################################
# File Name: diffeq.py
# Purpose: Provide class for doing 
#          numerical integration
# Creation Date: 16-06-2015
# Created By: Chris Richardson
############################################

class Sim():
    """Provides numerical integration of ordinary differential equations."""
    
    def __init__(self):
        # Public
        self.step_size = None
        self.initial_state = None
        self.initial_time = None

        # Private
        self.__integrator_type = 'euler'
        self.__deriv_func = None
        self.__current_state = self.initial_state
        self.__current_time = self.initial_time

    def setIntegratorType(self, integrator_type):
        """Set the integrator type (rk4, euler)."""
        if integrator_type not in ['euler','rk4']:
            raise ValueError("Integrator type not recognized.")
        else:
            self.__integrator_type = integrator_type

    def getIntegratorType(self):
        return self.__integrator_type

    def derivFunc(self, deriv_func):
        """Provide name of the derivative function of the form: xdot = f(t,x)."""
        import types
        if not isinstance(deriv_func, types.FunctionType):
            raise ValueError("Input to derivFunc() must be a function object!")
        else:
            self.__deriv_func = deriv_func

    def resetState(self):
        self.__current_state = self.initial_state
        self.__current_time = self.initial_time

    def step(self):
        if self.__integrator_type == 'euler':
            stepEuler()
        elif self.__integrator_type == 'rk4':
            stepRk4()

    def stepEuler(self):
        self.__current_state += self.step_size \
            * self.__deriv_func(self.__current_time, self.__current_state)
        self.__current_time += self.step_size


    def stepRk4(self):
        h_2 = self.step_size / 2.
        k1 = deriv_func(self.__curr_time,
                        self.__curr_state)
        k2 = deriv_func(self.__curr_time + h_2,
                        self.__curr_state + h_2 * k1)
        k3 = deriv_func(self.__curr_time + h_2,
                        self.__curr_state + h_2 * k2)
        k4 = deriv_func(self.__curr_time + self.step_size,
                        self.__curr_state + self.step_size * k3)

        self.__current_state += self.step_size / 3. \
            * (k1 + 2. * k2 + 2. * k3 + k4)
        self.__current_time += self.step_size

    def state(self):
        return self.__current_state

    def time(self):
        return self.__curent_time
